; multi-segment executable file template.

data segment
string1 db "gunes"
string2 db "gones"
a db "esit$"
b db "esitdegil$"  
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    lea si,string1
    lea di, string2
    mov cx,5
    
    repe cmpsb  ; repe nin repten farki esitse cx in degerini azaltir 
    ; 2 sekilde dongunden çikar 
    ;1.  cx 0 olursa
    ;2. esit olmayan durum olursa 
    
    je esit      ; esit ise stringler esit etiketine dallan
    
    mov ah,09    ; Esit degil ise bu komut grubu icra edilecek 
    lea dx,b     ;
    int 21h      ;             
    
    jmp son      ; sartsiz dallanma etiketi esit olamam durumunda esit yazisinin tekrar yazilmamasi icin 
    
    esit:        ; programin esit etiketinden dolayi dallandigi yer
    
    mov ah,09    ;
    lea dx,a     ; Esit ise bu komutlar icra edilecek ve ekrana esit yazisi yazilacak
    int 21h      ;
    
    son:         ; sartsiz dallanma etiketi 
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
