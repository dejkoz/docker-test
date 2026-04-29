#!/bin/bash

echo '#!/bin/bash' > run.sh
echo 'echo "Zaganjam Test 1"' >> run.sh
chmod +x run.sh
bash ./pripravi_izvajalno_okolje.sh git@github.com:dejkoz/ORV.git
