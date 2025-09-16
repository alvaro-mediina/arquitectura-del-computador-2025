# 📖 Teórico

## 🤨Excepciones e interrupciones
- **Excepción**: Todo evento inesperado que modifica el flujo de control del programa. No se puede seguir con la ejecución del código.
- **Interrupción**: Provocada por un controlador I/O externo. Una interrupción es *también* una *excepción*

## 🐊 Manejo de excepciones
Tenemos que poder hacer:
- *🫵 Salvar el PC de alguna ofenza:* Link de referencia a la posición de memoria donde se produjo la excepción
	- Se guardará en *Exception Link Register (ELR)*
- *🫵🧐 Salvar la indicación del problema:* Tipo/Origen de excepción que saltó
	- Se guardará en *Exception Syndrome Register (ESR)*

## 👷‍♂️ Acciones del controlador
- Poder leer la ESR
- Determinar una acción requerida
- ✅ Si reiniciable, tomar una accion correctiva, EPC(Exception Program Counter) para volver al programa
- ❌ En cualquier otro caso, terminar el programa y reportar el error utilizando EPC, causa,...

## Tipos de excepciones
- *Externas*: Cualquiera que llegue al *CONTROLLER*
- *Internas*: Opcode inválido.

## Nuevas entradas
![[Pasted image 20250915235004.png]]
**CONTROLLER**
- *ExtlRQ*: Para excepciones externas.
-  *ExtlAck*: Para avisar de controller al hardware que generó la excepción que la recibió.
- *Estatus[3..0]* : Para transportar el tipo de excepción. Como son 4 bits tengo hasta 16 códigos de excepciones.
- *ERet*:
- *Exc*: Excepción interna generada.
- *ExcAck*: Recibir el aviso del *DATAPATH* sobre la excepción interna generada.

## Nuevas instrucciones
- *ERET*(Exception Return): No toma argumentos, simplemente carga el *Exception Return Register (ERR)* y lo carga en el PC
- *MRS*(Move (From) SystemReg to GeneralPurposeReg): Mover del *SystemReg* hacia el *GeneralPurposeReg*
	- MRS <RT>, <systemReg> 