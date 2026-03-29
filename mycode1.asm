org 100h

.data
    dora_x    dw 150           
    dora_y    dw 80            
    old_x     dw 150           
    old_y     dw 80            
    size_w    dw 34
    size_h    dw 32
    char_type db 0              ; 

.code
start:
    mov ax, 13h
    int 10h

game_loop:
   
    mov al, 0               
    mov cx, old_x 
    sub cx, 2
    mov dx, old_y 
    sub dx, 2
    mov si, size_w 
    mov di, size_h
    call draw_rect

    
    mov ax, dora_x 
    mov old_x, ax
    mov ax, dora_y 
    mov old_y, ax

   
    mov ah, 01h             
    int 16h
    jz redraw_char          
    
    mov ah, 00h             
    int 16h
    
 
    cmp al, 'n'
    je switch_char
    
   
    cmp al, 'w'
    je move_up
    cmp al, 's'
    je move_down
    cmp al, 'a'
    je move_left
    cmp al, 'd'
    je move_right
    jmp redraw_char

switch_char:
    xor char_type, 1        
    jmp redraw_char

move_up:    sub dora_y, 5 
jmp redraw_char
move_down:  add dora_y, 5 
jmp redraw_char
move_left:  sub dora_x, 5 
jmp redraw_char
move_right: add dora_x, 5

redraw_char:
   
    cmp char_type, 0
    je draw_dora_label
    call draw_nobita
    jmp end_draw

draw_dora_label:
    call draw_doraemon

end_draw:
    call fast_delay
    jmp game_loop           


draw_nobita proc
   
    mov al, 12              
    mov cx, dora_x 
    mov dx, dora_y 
    mov si, 28 
    mov di, 26
    call draw_rect

 
    mov al, 0
    mov cx, dora_x 
    mov dx, dora_y 
    mov si, 28 
    mov di, 8
    call draw_rect


    mov al, 0

    mov cx, dora_x 
    add cx, 4 
    mov dx, dora_y 
    add dx, 10
    mov si, 8 
    mov di, 8 
    call draw_rect
    mov al, 15 
    mov cx, dora_x 
    add cx, 5 
    mov dx, dora_y 
    add dx, 11
    mov si, 6 
    mov di, 6 
    call draw_rect
    

    mov al, 0
    mov cx, dora_x 
    add cx, 16 
    mov dx, dora_y 
    add dx, 10
    mov si, 8 
    mov di, 8 
    call draw_rect
    mov al, 15 
    mov cx, dora_x 
    add cx, 17 
    mov dx, dora_y 
    add dx, 11
    mov si, 6 
    mov di, 6 
    call draw_rect
    
  
    mov al, 0
    mov cx, dora_x 
    add cx, 10 
    mov dx, dora_y 
    add dx, 22
    mov si, 8 
    call draw_hline
    ret
draw_nobita endp


draw_doraemon proc
    mov al, 1
    mov cx, dora_x 
    mov dx, dora_y 
    mov si, 30 
    mov di, 28
    call draw_rect
    mov al, 15
    mov cx, dora_x 
    add cx, 5 
    mov dx, dora_y 
    add dx, 8 
    mov si, 20 
    mov di, 18
    call draw_rect
    mov al, 0
    mov cx, dora_x 
    add cx, 8 
    mov dx, dora_y 
    add dx, 12 
    mov si, 3 
    mov di, 4 
    call draw_rect
    mov cx, dora_x 
    add cx, 19 
    call draw_rect
    mov al, 4
    mov cx, dora_x 
    add cx, 13 
    mov dx, dora_y 
    add dx, 17 
    mov si, 4 
    mov di, 3 
    call draw_rect
    ret
draw_doraemon endp

draw_rect proc
    push cx 
    push dx
    mov bx, di              
row_l:
    push cx 
    mov bp, si              
pix_l:
    mov ah, 0ch 
    int 10h
    inc cx 
    dec bp 
    jnz pix_l
    pop cx 
    inc dx 
    dec bx 
    jnz row_l
    pop dx 
    pop cx 
    ret
draw_rect endp

draw_hline proc
    mov ah, 0ch
hl: int 10h 
inc cx 
dec si 
jnz hl
    ret
draw_hline endp

fast_delay proc
    mov cx, 01FFFh
d_l: loop d_l
    ret
fast_delay endp

end start