import numpy

aa=[]
u=0
result = []

c1=[]
c2=[]
c3=[]

with open("10182r1r2", 'r') as inin:
    for line in inin:
        line = line.strip()
        jj=line.split("@")
        c1.append(jj[0])
        c2.append(jj[1]+"@"+jj[2])

inin.close()
r1r2=dict(zip(c1, c2))












jilu=open("jilu",'w')

with open("r1r2and150ref", "r") as file:
    for line in file:
        u=u+1
        print(u)
        line = line.strip()
        cc = line.split()
        seq2=cc[5]
        cc0=cc[0]
        kkk=cc0.split("_")[0]
        kkk2=r1r2[kkk].split("@")
        se111=kkk2[0]
        se222=kkk2[1]
        seq1=se222
        print(seq1)
        print(seq2)


        zz = [0 for i in range(len(seq1) + 1)]
        jiejie1 = []
        jiejie2 = []
        jiejie3 = zz
        zj = 0
        for i in range(1, len(seq2) + 1):
            for j in range(1, len(seq1) + 1):
                x = zz[j - 1]
                y = zz[j]
                z = zj
                if (seq2[i - 1] == seq1[j - 1] ):
                    match = 2
                else:
                    match = -6

                gap1_score = z - 6
                gap2_score = y - 6
                match_score = x + match
                score = max(gap1_score, gap2_score, match_score)
                if score > 0:
                    zj = score
                else:
                    zj = 0
                jiejie1.append(zj)
            jiejie2 = [0]
            jiejie2.extend(jiejie1)
            zz = jiejie2
            jiejie3.extend(jiejie2)
            jiejie1 = []
            jiejie2 = []
            zj = 0

        best_matrix = numpy.array(jiejie3).reshape(len(seq2) + 1, len(seq1) + 1)
        aa = numpy.where(best_matrix == numpy.max(best_matrix))
        i = aa[0][-1]
        j = aa[1][-1]
        ks1 = i
        ks2 = j
        s1 = ""
        s2 = ""
        while best_matrix[i, j] != 0:
            if seq2[i - 1] == seq1[j - 1]:
                match = 2
            else:
                match = -6
            if i > 0 and j > 0 and best_matrix[i, j] == best_matrix[i - 1, j - 1] + match:
                s1 = s1 + seq1[j - 1]
                s2 = s2 + seq2[i - 1]
                i = i - 1
                j = j - 1
            elif i > 0 and best_matrix[i, j] == best_matrix[i - 1, j] - 6:
                s1 = s1 + '-'
                s2 = s2 + seq2[i - 1]
                i = i - 1
            else:
                s1 = s1 + seq1[j - 1]
                s2 = s2 + '-'
                j = j - 1
        print(str(ks1)+"@"+str(ks2),file=jilu)


    file.close()
    jilu.close()
