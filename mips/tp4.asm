
.text                        
       .globl main   

main:  la     $s0, n
       lw     $s0, 0($s0)   # $s0 = n = 6
       la     $s5, A        # $s5 = A
       la     $s6, B        # $s6 = B
       la     $s7, C        # $s7 = C

       add    $s2, $0, $0   # $s2 = sum_a = 0
       add    $s3, $0, $0   # $s3 = sum_b = 0
       add    $s4, $0, $0   # $s4 = sum_c = 0

       add    $t3, $0, $0   # i = 0

sum:   lw     $t0, 0($s5)          # $t0 = a[i]
       add    $s2, $s2, $t0        # $s2 += a[i] 
       lw     $t0, 0($s6)          # $t0 = b[i]
       add    $s3, $s3, $t0        # $s3 += b[i]
       lw     $t0, 0($s7)          # $t0 = c[i]
       add    $s4, $s4, $t0        # $s4 += c[i]
       addi   $t3, $t3, 1          # i++
       addi   $s5, $s5, 4          # pega próximo de A
       addi   $s6, $s6, 4          # pega próximo de B
       addi   $s7, $s7, 4          # pega próximo de C
       bne    $t3, $s0, sum        # stop loop (mudar de end)

       la     $s5, A        # $s5 = A
       la     $s6, B        # $s6 = B
       la     $s7, C        # $s7 = C

media: add    $s1, $s2, $0  # $s1 = sum_a
       jal    divisao       # $v1 = sum_a / n
       add    $s2, $v1, $0  # sum_a = $v1
       add    $s1, $s3, $0  # $s1 = sum_b
       jal    divisao       # $v1 = sum_b / n
       add    $s3, $v1, $0  # sum_b = $v1
       add    $s1, $s4, $0  # $s1 = sum_c
       jal    divisao       # $v1 = sum_c / n
       add    $s4, $v1, $0  # sum_c = $v1

       add    $s1, $s2, $0         # $s1 = min = sum_a
       bgt    $s3, $s1, min_c      # if sum_b > min then skip B
       add    $s1, $s3, $0         # else, min = sum_b

min_c: bgt    $s4, $s1, prepare_d  # if sum_c > min then skip C
       add    $s1, $s4, $0         # else, min = sum_c


prepare_d:    la     $s2, D        # $s2 = D
              add    $s3, $0, $0   # $s3 = k = 0
              add    $t3, $0, $0   # $t3 = i = 0


sv_a:  lw     $t0, 0($s5)          # $t0 = a[i]
       bge    $t0, $s1, sv_b       # if a[i] > min then goto sv_b
       sw     $t0, 0($s2)          # d[k] = a[i]
       addi   $s3, $s3, 1          # k++     
       addi   $s2, $s2, 4          # próximo valor de d

sv_b:  lw     $t0, 0($s6)          # $t0 = b[i]
       bge    $t0, $s1, sv_c       # if b[i] > min then goto sv_c
       sw     $t0, 0($s2)          # d[k] = b[i]
       addi   $s3, $s3, 1          # k++     
       addi   $s2, $s2, 4          # próximo valor de d

sv_c:  lw     $t0, 0($s7)          # $t0 = c[i]
       bge    $t0, $s1, cond       # if c[i] > min then goto cond
       sw     $t0, 0($s2)          # d[k] = c[i]
       addi   $s3, $s3, 1          # k++     
       addi   $s2, $s2, 4          # próximo valor de d

cond:  addi   $s5, $s5, 4          # próximo valor de a
       addi   $s6, $s6, 4          # proximo valor de b
       addi   $s7, $s7, 4          # proximo valor de c
       addi   $t3, $t3, 1          # i++
       blt    $t3, $s0, sv_a       # if i < k then goto sv_a


st:    la     $t0, k
       sw     $s3, 0($t0)	# k = $s3
       
              

end:   j      end 
 

#################################################################################################
###  Divisão serial  $s1/ $s0 -->   $v0--> resto    $v1 --> divisão
################################################################################################
divisao:
          lui   $t0, 0x8000       # máscara para isolar bit mais significativo
          li    $t1, 32           # contador de iterações

          xor   $v0, $v0, $v0     # registrador P($v0)-A($v1) com  0 e o dividendo ($s1)
          add   $v1, $s1, $0

dloop:    and   $t2, $v1, $t0     # isola em t2 o bit mais significativo do registador 'A' ($v1)
          sll   $v0, $v0, 1       # desloca para a esquerda o registrado P-A
          sll   $v1, $v1, 1 

          beq   $t2, $0, di1    
          ori   $v0, $v0, 1       # coloca 1 no bit menos significativo do registador 'P'($v0)

di1:      sub   $t2, $v0, $s0     # subtrai 'P'($v0) do divisor ($s0)
          blt   $t2, $0, di2
          add   $v0, $t2, $0      # se a subtração deu positiva, 'P'($v0) recebe o valor da subtração
          ori   $v1, $v1, 1       # e 'A'($v1) recebe 1 no bit menos significativo

di2:      addi  $t1, $t1, -1      # decrementa o número de iterações 
          bne   $t1, $0, dloop 

          jr    $ra  

.data
d1:       .word    0x3FABCD   # 4.172.749  resposta: 2891(0xB4B) resto 1036(40C)
d2:       .word    0x5A3      # 1443
div:      .word    0
resto:    .word    0

n:        .word    6
k:        .word    0
A:        .word    101 900 500 34 182 910
B:        .word    60 180 912 302 291 411
C:        .word    97 714 561 700 123 712
D:        .word    0
        
