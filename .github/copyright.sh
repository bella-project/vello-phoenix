#!/bin/bash

# If there are new files with headers that can't match the conditions here,
# then the files can be ignored by an additional glob argument via the -g flag.
# For example:
#   -g "!src/special_file.rs"
#   -g "!src/special_directory"

# Check Rust files with egui copyright.
output=$(rg "^// Copyright 2022-2025 the Catalina, egui & Vello Authors$\n^// SPDX-License-Identifier: Apache-2\.0 OR MIT$\n\n" --files-without-match --multiline -g "examples/with_winit/multi_touch.rs" .)

if [ -n "$output" ]; then
	echo -e "The following files lack the correct copyright header:\n"
	echo $output
	echo -e "\n\nPlease add the following header:\n"
	echo "// Copyright 2022-2025 the Catalina, egui & Vello Authors"
	echo "// SPDX-License-Identifier: Apache-2.0 OR MIT"
	echo -e "\n... rest of the file ...\n"
	exit 1
fi

# Check all the standard Rust source files (excepting egui).
output=$(rg "^// Copyright 2022-2025 the Catalina & Vello Authors$\n^// SPDX-License-Identifier: Apache-2\.0 OR MIT$\n\n" --files-without-match --multiline -g "*.rs" -g "!examples/with_winit/multi_touch.rs" -g "!catalina_shaders/{shader,src/cpu}" .)

if [ -n "$output" ]; then
	echo -e "The following files lack the correct copyright header:\n"
	echo $output
	echo -e "\n\nPlease add the following header:\n"
	echo "// Copyright 2022-2025 the Catalina & Vello Authors"
	echo "// SPDX-License-Identifier: Apache-2.0 OR MIT"
	echo -e "\n... rest of the file ...\n"
	exit 1
fi

# Check all the shaders, both WGSL and CPU shaders in Rust, as they also have Unlicense
output=$(rg "^// Copyright 2022-2025 the Catalina & Vello Authors$\n^// SPDX-License-Identifier: Apache-2\.0 OR MIT OR Unlicense$\n\n" --files-without-match --multiline -g "catalina_shaders/{shader,src/cpu}/**/*.{rs,wgsl}" .)

if [ -n "$output" ]; then
        echo -e "The following shader files lack the correct copyright header:\n"
        echo $output
        echo -e "\n\nPlease add the following header:\n"
        echo "// Copyright 2022-2025 the Catalina & Vello Authors"
        echo "// SPDX-License-Identifier: Apache-2.0 OR MIT OR Unlicense"
        echo -e "\n... rest of the file ...\n"
        exit 1
fi

echo "All files have correct copyright headers."
exit 0

