.data
    n: .space 4
    x: .space 4
    k: .space 4
    s: .long 0
    n2: .space 4
    max: .long -1
    i: .space 4
    v: .space 500
    fs1: .asciz "%d"
    fs2: .asciz "Prima secventa cu suma maxima %d incepe pe pozitia %d\n"
    fs3: .asciz "%d\n"
.text
.globl main
main:

citire:
    pushl $n
    pushl $fs1
    call scanf
    pop %ebx
    pop %ebx

    pushl $k
    pushl $fs1
    call scanf
    pop %ebx
    pop %ebx


init:
    mov $0,%ecx
    lea v,%esi

citire_vector:
    cmp %ecx,n
    je init2

    pusha
    pushl $x
    pushl $fs1
    call scanf
    pop %ebx
    pop %ebx
    popa
    
    mov x,%eax
    mov %eax,(%esi,%ecx,4)
    inc %ecx
    jmp citire_vector


max_nou:
    mov %edi,max
    mov %ecx,i
    jmp cont

adaug:
    mov s,%edi
    cmp %edi,max
    jl max_nou

cont:
    incl n2
    inc %ecx
    jmp for

init2:
    mov $0,%ecx
    mov n,%eax
    sub k,%eax
    mov %eax,n
    mov k,%eax
    mov %eax,n2
    incl n

for:
    cmp %ecx,n
    je afisare

    mov %ecx,%ebx
    mov $0,%eax
    movl %eax,s
    
    for2:
        cmp %ebx,n2
        je adaug

        mov (%esi,%ebx,4),%eax
        mov s,%edi
        add %edi,%eax
        mov %eax,s

        inc %ebx
        jmp for2
    



afisare:
    pushl i
    pushl max
    pushl $fs2
    call printf
    pop %ebx
    pop %ebx
    pop %ebx

exit:
    mov $1,%eax
    xor %ebx,%ebx
    int $0x80
