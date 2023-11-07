#!/usr/bin/python3
import sys
import os

if len(sys.argv) < 4:
    print("""
input as below
command [output signal name] [input signal name] [bit number]
""")
    exit()

save_file = 'check_connection_test.txt'
output_signal_name = sys.argv[1]
input_signal_name  = sys.argv[2]
bit_number = sys.argv[3]
print('output signal name = ' + output_signal_name)
print('input signal name  = ' + input_signal_name)
print('bit number = ' + bit_number)

if not os.path.isfile(save_file):
    f = open(save_file, 'w')
else:
    f = open(save_file, 'w')

    #with open(save_file, a) as f:

f.write("   initial begin\n")
data = 0
for i in range(int(bit_number)+2):
    #print(data)
    if i == 0:
        f.write("      force %s = %s'd%d;\n" % (output_signal_name, bit_number, data))
        data += 1
    elif i == 1:
        f.write("      force %s = %s'd%d;\n" % (output_signal_name, bit_number, data))
        data *= 2
    elif i == int(bit_number)+1:
        f.write("      force %s = %s'd%d;\n" % (output_signal_name, bit_number, data-1))
    else:
        f.write("      force %s = %s'd%d;\n" % (output_signal_name, bit_number, data))
        data *= 2
    f.write("      #10;\n")
    #f.write('      $display("%d");\n\n' % i)
    f.write('      if ( %s == %s ) begin\n' % (output_signal_name, input_signal_name))
    f.write('         $display("PASS  %b %b %0d %0d", '+output_signal_name+', '+input_signal_name+', '+output_signal_name+', '+input_signal_name+');\n')
    f.write('      end else begin\n')
    f.write('         $display("ERROR %b %b %0d %0d", '+output_signal_name+', '+input_signal_name+', '+output_signal_name+', '+input_signal_name+');\n')
    f.write('      end\n\n')
f.write('   end\n')
f.close()

print('save file = ' + save_file)
print()
