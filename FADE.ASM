;HACE UN FADE DE COLORES ENTRE UN COLOR DE INCIO (SETEADO EN LA POS. 0201) Y UN COLOR FINAL (SETEADO EN LA POS. 0202)

;Cambiar colores:

;0200: variable
;0201: código de color de inicio	- 11	otro, 52
;0202: código de color final	- 1F	otro, 5F

mov ax,13
int 10		 ; Esto pasa a modo gráficos

mov al,[0201]	 ; copia el color que hay en la variable de inicio
mov [0200],al	 ; lo pone en la variable


;sumar (10b):
mov dx, 111 (posición siguiente al jmp) ; puntero de retorno
jmp 0300	 ; andá a pintar la pantalla

add al,1	 ; sumale uno al color
mov bl,[0202]	 ; mové a bl el color final
cmp al,bl 	 ; llegamos?
je (restar)	 ; si es igual terminaste, andá a 130 que hay que ir p/atras
mov [0200],al    ; sino, actualizá la variable
jmp (sumar)	 ; pintame la pantalla otra vez


;restar (0130):
mov dx, 136(posición siguiente al jmp) ; puntero de retorno
jmp 0300	 ; andá a pintar la pantalla

sub al,1	 ; restale uno al color
mov bl,[0201]	 ; mové a bl el color inicial
cmp al,bl 	 ; llegamos?
je (sumar)	 ;si es igual terminaste, andá a 0150 que hay que ir p/adel.
mov [0200],al    ; sino, actualizá la variable
jmp (restar)	 ; pintame la pantalla otra vez


;pintar pantalla: (0300)

mov edi,0009e100 ; posición del pixel izquierda arriba
mov cx,fff0	 ; todos los pixels que hay en la pantalla de 320x200
309:
mov [edi],al	 ; escribí el pixel: posición 110
add edi,1	 ; siguiente pixel
loop 309	 ; volvé a escribir el pixel hasta que termine el contador

mov cx,00ff	 ; esperá
mov ah,00	 ; para chequear el teclado
317: nop
int 16		 ; chequeá si se apretó una tecla
jz 0400		 ; si se apretó, salimos
loop 317
jmp dx		 ; volvé dónde el puntero te marque


;salir (0400):

int 20		 ; chau


;COLORES DE 11H A 20H Y SALTO AL PRINCIPIO
