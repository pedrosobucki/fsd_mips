
.text                        
       .globl main   

main:  
          #exemplo de uso da divisão
          la    $s1, d1
          lw    $s1,0($s1)      # lê o dividendo
          la    $s0, d2
          lw    $s0,0($s0)      # lê o divisor   

          jal   divisao         # resposta em $v0  $v1

          la    $t0, div
          sw    $v1,0($t0)      
          la    $t0, resto
          sw    $v0,0($t0)      

fim:      j      fim 
 

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
        
