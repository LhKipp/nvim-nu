#!/bin/bash
# Throwaway script to map the nushell nu-command directory structure to command names

fd .rs crates/nu-command/src/ > cmds.txt
sed -i '/mod\.rs/d' cmds.txt
sed -i 's;crates/nu-command/src/;;' cmds.txt
sed -i -E 's;conversions/?;;' cmds.txt
sed -i -E 's;into/;;' cmds.txt
sed -i -E 's;core_commands/;;' cmds.txt
sed -i -E 's;dataframe/(eager|series/date|series/indexes|series/masks|series/string|series)/;dfr/;' cmds.txt
sed -i '/dataframe\/values/d' cmds.txt
sed -i '/default_context/d' cmds.txt
sed -i '/experimental/d' cmds.txt
sed -i -E 's;env/;;' cmds.txt
sed -i -E 's;env_command;env;' cmds.txt
sed -i -E 's;filesystem/;;' cmds.txt
sed -i -E 's;filters/?;;' cmds.txt
sed -i '/util.rs/d' cmds.txt
sed -i '/lib.rs/d' cmds.txt
sed -i -E 's;keep/keep_;keep/;' cmds.txt
sed -i -E 's;formats/;;' cmds.txt
sed -i -E 's;generators/;;' cmds.txt
sed -i -E 's;network/;;' cmds.txt
sed -i '/platform/d' cmds.txt
sed -i -E '/shells\/(g|n|p|shells_)/d' cmds.txt
sed -i -E 's;strings/;;' cmds.txt
sed -i -E '/format\/command.rs/d' cmds.txt
sed -i -E 's;str_/;str/;' cmds.txt
sed -i -E 's;str/case/;str/;' cmds.txt
sed -i -E '/system/d' cmds.txt
sed -i -E '/viewers/d' cmds.txt
sed -i -E '/export/d' cmds.txt
sed -i -E '/test/d' cmds.txt
sed -i -E '/^\s*$/d' cmds.txt

sed -i -E 's;\.rs;;' cmds.txt
sed -i -E 's;_$;;' cmds.txt
sed -i -E 's;_;-;' cmds.txt
sed -i -E 's;/; ;' cmds.txt
sort -o cmds.txt cmds.txt

sed -i -E 's;update-cells;update cells;' cmds.txt
sed -i -E 's;par-each_group;par-each group;' cmds.txt

