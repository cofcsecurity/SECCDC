import os
import time
def f_s(l):
    a = l[l.rfind(' ')+1:-1]
    return a[a.rfind('/')+1:]
def l_s(l, i):
    return l.split()[i]
r_r = {}
p_s = [f_s(l)[f_s(l).rfind('/')+1:] for l in os.popen('sudo cat /etc/shells').readlines()[1:] if "/" in l]
b_s = [l_s(l, 1) for l in os.popen('sudo ps -aux').readlines()[1:] if f_s(l) in p_s]
o_l = os.popen('sudo systemctl -a --plain').readlines()
c_s = dict((l_s(l, 0), l_s(l, 2)) for l in o_l[:o_l.index("\n")])
i_p = [l for l in os.popen('sudo cat /etc/passwd').readlines()]
i_s = [l for l in os.popen('sudo cat /etc/shadow').readlines()]
while True:
    time.sleep(0.1)
    o_l = os.popen('sudo ps -aux').readlines()[1:]
    r_r = dict.fromkeys(r_r, False)
    for l in (l for l in o_l if f_s(l) in p_s and l_s(l, 1) not in b_s):
        if l_s(l, 1) not in r_r.keys():
            print("NEW SHL: shell=" + f_s(l) + ", pid=" + l_s(l, 1) + "|" + l[:-1])
        r_r[l_s(l, 1)] = True
    r_r.pop((x for x in r_r.keys() if r_r[x] == False), None)
    o_l = os.popen('sudo systemctl -a --plain').readlines()
    o_l = o_l[:o_l.index("\n")]
    for l in (l for l in o_l if l_s(l, 0) not in c_s.keys() or c_s[l_s(l, 0)] != l_s(l, 2)):
        print(("SRV ADD -> " if l_s(l, 0) not in c_s.keys() else "SRV CHN -> ") + l_s(l, 0) + ":" + l_s(l, 2))
        c_s[l_s(l, 0)] = l_s(l, 2)
    for p in [l for l in c_s.keys() if l not in [l_s(k, 0) for k in o_l]]:
        print("SRV DEL -> " + p + 0*c_s.pop(p, None))
    o_l = os.popen('sudo cat /etc/passwd').readlines()
    for l in (l for l in i_p if l not in o_l):
        print('PSW DEL: ' + i_p.pop(i_p.index(l))[:-1])
    for l in (l for l in o_l if l not in i_p):
        print('PSW ADD: ' + (l[:-1] + str(i_p.append(l) is None) * 0))
    o_l = os.popen('sudo cat /etc/shadow').readlines()
    for l in (l for l in i_s if l not in o_l):
        print('SHD DEL: ' + i_s.pop(i_s.index(l))[:-1])
    for l in (l for l in o_l if l not in i_s):
        print('SHD ADD: ' + (l[:-1] + str(i_s.append(l) is None) * 0))
# f_s - Find Shell in ps Line
# g_p - Get pid from line
# l_v - Get Service from Line
# l_t - Get Status from Line
# o_l - Output Lines
# p_s - Possible Shells
# b_s - Beginning Shells
# r_r - Reported and Running
# c_s - Current Status
# i_p - Initial Passwd
# i_s - Initial Shadow
