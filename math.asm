section .data
    transferData db 0, 0xa ;0=null and 0xa=10 means "\n" as ascii
    errorNeg db "Unable to print negative values to screen. Message from: makeNeg function",0xa
    backslashn db 0xa
    aboutDev db "Developed by 0rbianta.", 0xa
    
section .text
    global main
    
main:
    call printDev
    call printBackSlashN

    mov rax, 5 ;ascii 5. Think this as normal integer
    call makeAdd
    mov rax, 55  ;load rax on every operation. ascii 55 equals 7
    call makeSub
    mov rax, 2
    call makeMul
    mov rax, 104 ;ascii(52)=text(4). rax loaded for next operation with 52*2 because it will be a division operation 
    call makeDiv
    mov rax, 1
    call makeNeg
    mov rax, 50
    call makeInc
    mov rax, 52
    call makeDec
    
    jmp exit


makeAdd:
    add rax, 52 ;ascii value of 4 is 52. 52 equals 4. Means x=3 -> x=x+4
    mov [transferData], al ;point transferData memory addreas with rax data
    call printTransferData
    ret ;means "return" to caller function
    
makeSub:
    sub rax, 4 ;ascii 4, means x=ascii(55)=7 -> x=x-4
    mov [transferData], al ;load memory with new data
    call printTransferData ;print
    ret

makeMul:
    mov rbx, 26 ;load rbx registery to make multiplication(mul)
    mul rbx ;automatically makes rax=rax*rbx ;it will make 26*2=52, ascii(52) = text(4) So the result will be 4
    mov [transferData], al ;note: all the data will converted to normal values
    call printTransferData
    ret

makeDiv:
    mov edx, 0 ;clear dividend to get significant result
    mov rbx, 2 ;rbx loaded with 2
    div rbx ; rax=rax/rbx means rax=104/2
    mov [transferData], al ;load memory data with rax data
    call printTransferData ;print
    ret
    
makeNeg:
    neg rax ;unable to print negative value to screen but rax is "-2" right now. neg rax means "0-rax" 
    ;mov [transferData], al
    ;call printTransferData
    mov rax, 1
    mov rdi, 1
    mov rsi, errorNeg
    mov rdx, 74 ;74 byte = text lenght + 1 because of 0xa
    syscall
    ret

makeInc:
    inc rax
    mov [transferData], rax ; rax is a ascii value(51) means 3.
    call printTransferData
    ret

makeDec:    
    dec rax ;rax-1 means 52-1 =51, ascii(51)=3 so output is 3 on our screen
    mov [transferData], rax
    call printBackSlashN ;unknown error fix ;(
    call printTransferData
    ret
    

;utils
printTransferData:
    mov rax, 1
    mov rdi, 1
    mov rsi,transferData
    mov rdx, 2 ;2 byte entered
    syscall
    ret
    
printBackSlashN:
    mov rax, 1 ;sys_write
    mov rdi, 1 ;standart input
    mov rsi, backslashn
    mov rdx, 1 ;1 byte entered
    syscall
    ret

printDev:
    mov rax, 1
    mov rdi, 1
    mov rsi, aboutDev
    mov rdx, 22 ;22 byte entered
    syscall
    ret            

exit:
    mov rax, 60 ;sys_exit id
    mov rsi, 0
    syscall
