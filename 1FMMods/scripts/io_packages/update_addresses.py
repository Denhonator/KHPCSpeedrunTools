"""Helper functions to update address and script files in a single pass."""
import os
import sys
import json


def update(game, platform, language, offset_info, write_mods=False):
	"""."""
	offset_info = json.loads(offset_info)
	file_path = os.path.realpath(__file__)
	address_path = f"{platform}{language}.lua"
	if game == "kh1" and write_mods:
		update_target_address(offset_info, file_path.split("io")[0])
	with open(file_path.split("up")[0] + address_path, "r+") as address_file:
		with open(file_path.split("up")[0] + "template.lua", "r") as template_file:
			address_lines = address_file.read().split("\n")
			address_file.seek(0)
			for idx, line in enumerate(template_file):
				if "0x0" in line:
					old_addresses = [x for x in address_lines[idx].split() if x.startswith("0x")]
					if len(old_addresses) == 1:
						target = int(old_addresses[0], 16)
						for key, val in offset_info.items():
							if int(val[0], 16) < target < int(val[1], 16):
								new_val = hex(target + int(key, 16)).upper().replace("X", "x")
								address_lines[idx] = line.replace("0x0", new_val)
					else:
						new_addresses = []
						for address in old_addresses:
							address = address.replace(",", "")
							target = int(address, 16)
							for key, val in offset_info.items():
								if int(val[0], 16) < target < int(val[1], 16):
									new_val = hex(target + int(key, 16)).upper().replace("X", "x")
									new_addresses.append(new_val)
									break
						address_lines[idx] = line.replace("0x0", "{}").format(*new_addresses)
				else:
					address_lines[idx] = line
			address_file.writelines(address_lines)
			address_file.truncate()
	

def update_target_address(offset_info, script_dir):
	"""."""
	target = None
	for script in os.listdir(script_dir):
		if not script.endswith(".lua"):
			continue
		with open(f"{script_dir}/{script}", "r+") as mod:
			lines = mod.read().split("\n")
			mod.seek(0)
			for idx, line in enumerate(lines):
				if "local posDebugString" in line:
					line_parts = [line.split(" = ")[0], " = ", line.split(" = ")[1]]
					if not target:
						target = int(line_parts[2], 16)
					for key, val in offset_info.items():
						if int(val[0], 16) < target < int(val[1], 16):
							line_parts[2] = hex(target + int(key, 16)).upper().replace("X", "x")
							break
					lines[idx] = "".join(line_parts) + "\n"
				else:
					lines[idx] = line + "\n"
			mod.writelines(lines)
			mod.truncate()

if __name__ == "__main__":
	print("running update")
	mods = False
	if len(sys.argv) > 5:
		mods = True
	update(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], mods)
