org 100h

.code
start:
    ; 1. เข้าสู่ Graphics Mode 13h (320x200 pixels)
    mov ax, 13h
    int 10h

    ; --- STEP 1: วาดส่วนหัว (สีฟ้า - Color 1) ---
    mov al, 1               ; สีน้ำเงิน/ฟ้า
    mov cx, 150             ; พิกัด X
    mov dx, 80              ; พิกัด Y
    mov si, 30              ; กว้าง
    mov di, 28              ; สูง
    call draw_rect

    ; --- STEP 2: วาดใบหน้าขาว (สีขาว - Color 15) ---
    mov al, 15              ; สีขาว
    mov cx, 155             ; ขยับเข้ามาด้านใน
    mov dx, 88              
    mov si, 20
    mov di, 18
    call draw_rect

    ; --- STEP 3: วาดดวงตา (สีดำ - Color 0) ---
    mov al, 0               ; สีดำ
    ; ตาซ้าย
    mov cx, 158
    mov dx, 92
    mov si, 3 
    mov di, 4 
    call draw_rect
    ; ตาขวา
    mov cx, 169 
    mov dx, 92 
    mov si, 3 
    mov di, 4 
    call draw_rect

    ; --- STEP 4: วาดจมูก (สีแดง - Color 4) ---
    mov al, 4               ; สีแดง
    mov cx, 163 
    mov dx, 97 
    mov si, 4 
    mov di, 3 
    call draw_rect

    ; --- STEP 5: วาดปาก (เส้นตรงสีดำ - Color 0) ---
    mov al, 0
    mov cx, 158             ; X เริ่มต้น
    mov dx, 103             ; Y
    mov si, 14              ; ความยาวเส้นปาก
    call draw_hline

    ; รอการกดปุ่มเพื่อจบโปรแกรม
    mov ah, 00h
    int 16h
    mov ax, 03h             ; กลับเข้าสู่ Text Mode
    int 10h
    ret

; --- ฟังก์ชันวาดสี่เหลี่ยมระบายสี ---
draw_rect proc
    push cx
    push dx
    mov bx, di              ; ใช้ BX คุมความสูง
row_loop:
    push cx
    mov bp, si              ; ใช้ BP คุมความกว้าง
pixel_loop:
    mov ah, 0ch             ; เขียนจุดพิกเซล
    int 10h
    inc cx
    dec bp
    jnz pixel_loop
    pop cx
    inc dx
    dec bx
    jnz row_loop
    pop dx
    pop cx
    ret
draw_rect endp

; --- ฟังก์ชันวาดเส้นตรงแนวนอน ---
draw_hline proc
    mov ah, 0ch
hline_loop:
    int 10h
    inc cx
    dec si
    jnz hline_loop
    ret
draw_hline endp

end start