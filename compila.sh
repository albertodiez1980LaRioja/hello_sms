./sdcc/bin/sdcc -mz80 --peep-file peep-rules.txt main.c
#./sdcc/bin/sdcc -mz80 --peep-file peep-rules.txt bank1.c
#./sdcc/bin/sdcc -mz80 --peep-file peep-rules.txt bank2.c
./sdcc/bin/sdcc -mz80 --constseg BANK1 bank1.c
./sdcc/bin/sdcc -mz80 --constseg BANK2 bank2.c
./sdcc/bin/sdcc -mz80 --constseg BANK3 bank3.c
#./sdcc/bin/sdcc -o output.ihx -mz80 --data-loc 0xC000  --no-std-crt0 crt0_sms.rel main.rel bank1.rel bank2.rel PSGlib.rel SMSlib.lib
./sdcc/bin/sdcc -o output.ihx -mz80 --data-loc 0xC000 -Wl-b_BANK1=0X8000 -Wl-b_BANK2=0X8000 --no-std-crt0 crt0_sms.rel main.rel bank1.rel bank2.rel PSGlib.rel SMSlib.lib
./ihx2sms output.ihx output.sms
#./makesms output.ihx output.sms