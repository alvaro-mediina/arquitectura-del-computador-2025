# 📖 Teórico

## 😯 Frecuencia vs Periodo
$$
\frac{1}{T} = f, \quad T = \frac{1}{f} 
$$
- Cuando te dan un ejercicio que tiene *GHz* y te piden calcular el tiempo de ejecución tenés que usar la fórmula que define al *periodo*, tal que $T = \frac{1}{f}$.

- Por otro lado cuando te dan un ejercicio que tiene el *periodo de clock* y te piden calcular la $Vel_{clock}$ entonces utilizar la fórmula que define *frecuencia*. 
## 🪖 Forwarding
Únicas formas de hacer *forwarding*:
- Desde la salida de la *ALU* hacia OPERANDOS.
- Desde la salida de *MEMORY* hacia OPERANDOS.
- *CASO PARTICULAR*: Buscamos un dato de la memoria y lo necesito usar en la siguiente instrucción. *Necesariamente* tengo que esperar 1 ciclo de clock para recién *forwardear*.

## 🐊 Hazard vs Dependencias
- *Dependencias de datos*: Por cómo escribo el código tengo una dependencia entre distintos operandos que voy utilizando. *Pej: Este X2 usado en línea 2 depende de X2 almacenado en línea 1*.

- *Hazard*: Causado por una dependencia en algún tipo de Hardware. Se resuelven mediante forwarding. 

### 🐊 Hazard
- *Hazard estructurales:* Cuando se requiere un recurso que está ocupado.
- *Hazard de control:* Decidir sobre una acción de control depende de la instrucción previa.
- *Hazard de dato:* Necesita esperar a la intrucción previa complete la lectura/escritura del dato.

### 🐊 Hazard de control
Técnicas para evitar *hazards de control*.
- Técnicas estáticas:
	- Not Taken (NT): Por defecto se asume que el salto NO SE TOMA y se carga la siguiente instrucción. En caso que el salto deba tomarse, se hace flush y se realiza el fetch de la instrucción correcta. La penalidad es de 3 ciclos de clock.
	- Taken (T): Por defecto el procesador asume que el salto SE TOMA y carga la instrucción que indica el salto. Esto en un procesador como el que venimos estudiando tiene una penalidad de 3 clocks siempre (la decisión de si el salto debe tomarse se realiza en la etapa de memory).
- Técnicas dinámicas: El procesador decide si saltar o no considerando el historial de saltos propios o global.


## 🤸‍♂️ Procesador optimizado para saltos
- Inicialmente es un *procesador con pipeline*.
- Agrega un *Hazard Detection Unit*.
- Agrega un *Forwarding Unit*.
---
# 🪖 Práctico 
## Ejercicio 1
En un microprocesador con tres etapas de pipeline: *S1 -> S2 -> S3* , con tiempos de ejecución *T1 = T3 = T y T2 = 3T.*

![[Pasted image 20250910172324.png]]

*a) ¿Cuál de los tres segmentos o etapas causa la congestión? (el cuello de botella)*

- De los tres segmentos o etapas la que causa congestión (cuello de botella) es la *etapa 2*

*b) Asumiendo que el segmento problemático se puede dividir en dos etapas consecutivas, ninguna de ellas con duración menor que T, ¿cuál sería la mejor partición posible? ¿Cuál sería el período de clock resultante para este nuevo pipeline de 4 etapas? *

- La mejor partición posible sería *1.5T* cada una de esas etapas por lo tanto el período de clock resultante para este nuevo pipeline de 4 etapas sería de *1.5T*

*c) Asumiendo que el segmento problemático se puede dividir en varias etapas consecutivas de duración T, ¿cuál es el período de clock del microprocesador? ¿Cuál es el tiempo de ejecución entre instrucciones?*

- El periodo de clock del microprocesador sería de *T*
- El tiempo de ejecución entre instrucciones sería de *T*

## Ejercicio 2
Asumiendo que las etapas de un procesador ARM tienen las siguientes latencias:

|  IF  |  ID  | EX  | MEM  |  WB  |
|:----:|:----:|:---:|:----:|:----:|
| 30ns | 10ns | 9ns | 40ns | 20ns |
*a) ¿Cuánto tiempo se requiere en un microprocesador sin pipeline para completar la ejecución de la instrucción de mayor latencia, es decir, la latencia del procesador completo?*

$\text{Latencia del procesador completo} = 30ns+10ns+9ns+40ns+20ns = 109ns$

Particularmente la suma de todas las etapas.

*b) Si se requiere ejecutar esa instrucción en un microprocesador con pipeline, ¿a qué velocidad debería trabajar el clock?*

Para este caso sumo la etapa mas lenta en la cantidad de etapas:

Periodo de cada clock : $T = 40ns$

$Vel_{clock} = \frac{1}{T} = \frac{1}{200ns} = 25MHz$

*c) ¿Cuál es el tiempo de ejecución de una instrucción en un microprocesador con pipeline? ¿Cada cuanto se ejecuta una nueva instrucción en este procesador? *

- Tiempo de ejecución de una instrucción en un micro con pipeline: $40ns*5 = 200ns$
- Una nueva instrucción se ejecuta en el procesador cada: $40ns$

*d) Si un microprocesador con pipeline ejecuta 3 instrucciones consecutivas ¿cuál es la ganancia de velocidad de un procesador con pipeline respecto de uno sin pipeline? ¿Y si se ejecutan 1000 instrucciones consecutivas?*

$$
\text{Ganancia de velocidad} = \frac{\text{Tiempo de ejecución sin pipeline}}{\text{Tiempo de ejecución con pipeline}}
$$

Como se ejecutan 3 instrucciones consecutivas tenemos: 
- Con pipeline: $(40ns*5)*3 = 600ns$
- Sin pipeline: $109ns * 3 = 327ns$

Luego tenemos:
$$
\text{Ganancia de velocidad} = \frac{109ns * 3}{(40ns * 5)+ 2*40} = 1.168 
$$
Ahora si se ejecutan 1000 instrucciones consecutivas:

$$
\text{Ganancia de velocidad} = \frac{109ns * 1000}{(40ns * 5)+ 999*40} = 2.714
$$

## Ejercicio 3
Asumiendo que las etapas individuales del pipeline de dos procesadores ARM distintos tienen las siguientes latencias:

| CASO | IF  | ID  | EX  | MEM | WB  | Unidad |
|:----:|:---:|:---:|:---:|:---:|:---:|:------:|
|  1   | 300 | 400 | 350 | 500 | 100 |   ps   |
|  2   | 200 | 150 | 120 | 190 | 140 |   ps   |
*a) ¿Cuál es el ciclo de clock para la versión con y sin pipeline para cada caso?*
- Versión con pipeline:
	- Caso 1: 500ns
	- Caso 2: 200ns
- Versión *sin* pipeline:
	- Caso 1: 300ns+400ns+350ns+500ns+100ns = 1650ns 
	- Caso 2: 200ns+150ns+120ns+190ns+140ns = 700ns

*b) ¿Cuál es la latencia de la instrucción LDUR para ambos, considerando las versiones de procesador con y sin pipeline?*

- Versión con pipeline: 
	- Caso 1: 500ns * 5 = 2500ns
	- Caso 2: 200ns * 5 = 1000ns
- Versión sin pipeline: 
	- Caso 1: 1650ns
	- Caso 2: 700ns

*c) Si se pudiera partir una etapa del pipeline en dos nuevas etapas, cada una con la mitad de la latencia de la etapa original, ¿Que etapa elegiría y cuál será el nuevo ciclo de clock?*

- Caso 1: Elegiría la etapa de MEM y el nuevo clock sería 400ns por el IF.
- Caso 2: Elegiría la etapa de IF y el nuevo clock sería 190ns por el MEM.

## Ejercicio 4
Dados los siguientes fragmentos de código de instrucciones LEGv8:
![[Pasted image 20250910222823.png]]
*a) Analizar en el código las dependencias de datos. En cada caso indicar: los números de las instrucciones involucradas y el operando en conflicto.*

### Código A
| Dependencia de tipo | Números de instrucciones involucradas | Operando en conflicto |
| ------------------- | ------------------------------------- | --------------------- |
| Dato                | 1,2                                   | X6                    |

### Código B

| Dependencia de tipo | Números de instrucciones involucradas | Operando en conflicto |
| ------------------- | ------------------------------------- | --------------------- |
| Dato                | 1,2                                   | X10                   |
| Dato                | 1,3                                   | X10                   |

### Código C

| Dependencia de tipo | Números de instrucciones involucradas | Operando en conflicto |
| ------------------- | ------------------------------------- | --------------------- |
| Dato                | 1,3                                   | X1                    |
| Dato                | 2,3                                   | X2                    |
| Dato                | 3,4                                   | X3                    |
| Dato                | 5,6                                   | X4                    |
| Dato                | 1,6                                   | X1                    |
| Dato                | 6,7                                   | X5                    |


*b) Mostrar el orden de ejecución de las instrucciones y determinar cuales generan data hazards. En cada caso indicar en qué etapa se genera el hazard.*

**Código A**

![[Pasted image 20250910230759.png]]

**Código B**

**Código C**

![[Pasted image 20250911115245.png]]

*b') Mostrar el orden de ejecución de las instrucciones utilizando un procesador con forwarding stall.* 

**Código A**

![[Pasted image 20250910232248.png]]

**Código B **

**Código C**

![[Pasted image 20250911115301.png]]

*c) Reescribir la sección de código alterando el orden de las instrucciones para evitar stalls innecesarios. Mostrar el nuevo orden de ejecución.* 

- *Código A*: Como tiene dos instrucciones y la *línea 2* sí o si depende de la otra no se puede reescribir la sección de código SÓLO alterando el órden.
- Código B:
- *Código C:*

![[Pasted image 20250911120526.png]]

*d) ¿Cuántos ciclos toma la ejecución del código en cada caso?*
- *Código A:* 
	- En el caso de utilizar *stall* toma 8 ciclos de clock.
	- En el caso de utilizar *forwarding-stall* toma 6 ciclos de clock.
- Código B:
- *Código C:*
	- En el caso de utilizar *stall* toma 19 ciclos de clock.
	- En el caso de utilizar *forwarding-stall* toma  13 ciclos de clock
	- *Alterando el órden* de las instrucciones para evitar stalls innecesarios toma 11 ciclos de clock

## Ejercicio 5
Dados los siguientes fragmentos de código de instrucciones LEGv8:

![[Pasted image 20250914104651.png]]

a) Mostrar el orden de ejecución de las instrucciones utilizando un procesador con stall.

**Código A**
![[Pasted image 20250914113314.png]]

**Código B**
![[Pasted image 20250914113337.png]]

b) Mostrar el orden de ejecución de las instrucciones utilizando un procesador con forwarding stall

**Código A**
![[Pasted image 20250914114724.png]]

**Código B**

![[Pasted image 20250914114740.png]]

c) Agregar instrucciones nop a las secuencias ‘A’ y ‘B’ para asegurar la correcta ejecución en un procesador sin soporte de forwarding stall. Mostrar gráficamente el orden de ejecución del programa en el pipeline. 

**Código A**
![[Pasted image 20250914120318.png]]

**Código B**
![[Pasted image 20250914120300.png]]

d) Considerando un clock de 1GHz, calcular el tiempo de ejecución de ambos programas para los tres casos anteriores.

Tenemos que el clock es de *1GHz*
Sea $\frac{1}{T} = 1GHz$
Tenemos que $T = \frac{1}{1GHz}$ donde $f=1GHz$
Como
$$
\begin{align}
1GHz &= 1 * 10⁹ Hz \\[0.1cm]
\end{align}
$$
Entonces
$$
\begin{align}
	\frac{1}{T} &= \frac{1}{1 * 10⁹}s\\
	T	&= 1 * 10^{-9}s\\
	T   &= 1 ns
\end{align}
$$
En cada caso debemos multiplicar 1ns por la cantidad de ciclos de clock que llevaron en ejecutarse cada programa

- Caso 1
	- Código A: 12ns
	
	- Código B: 14ns
- Caso 2
	- Código A: 8ns
	- Código B: 9ns
- Caso 3
	- Código A: 12ns
	- Código B: 12ns

## Ejercicio 6
Dado el siguiente fragmento de código de instrucciones LEGv8:
![[Pasted image 20250915064634.png]]
a) Analizar en el código las dependencias de datos y de control, determinar cuales generan hazards. En cada caso indicar: los números de las instrucciones involucradas, en qué etapa se encuentra c/u, el operando en conflicto y el tipo de hazard.

![[Pasted image 20250915071010.png]]

b) Mostrar el orden de ejecución de las instrucciones utilizando un procesador con forwarding stall suponiendo que X1 != X2. ¿Cuál es la penalidad por el hazard de control? 

![[Pasted image 20250915071630.png]]
No hay penalidad ya que se resuelve con *forwarding*

c) Mostrar el orden de ejecución de las instrucciones utilizando un procesador con forwarding stall suponiendo que X1 = X2. ¿Cuál es la penalidad por el hazard de control?
![[Pasted image 20250915072018.png]]
No hay penalidad por Hazzard ya que se maneja con *forwarding*

## Ejercicio 7
Para el siguiente fragmento de código de instrucciones LEGv8 que se ejecuta en un procesador con forwarding stall:
![[Pasted image 20250915073801.png]]
a) Analizar en el código las dependencias de datos y de control, determinar cuales generarían hazards y mediante qué técnica se evita. En cada caso indicar: los números de las instrucciones involucradas, el operando en conflicto y el tipo de hazard. 

![[Pasted image 20250915073740.png]]

b) Mostrar el orden de ejecución y los recursos utilizados por las instrucciones para el segmento de código dado, suponiendo que CBNZ no se toma. 

![[Pasted image 20250915075452.png]]

c) Mostrar el orden de ejecución y los recursos utilizados por las instrucciones para el segmento de código dado, suponiendo que CBNZ se toma una vez.

![[Pasted image 20250915075532.png]]

## Ejercicio 8
En la siguiente secuencia de código los registros X6 y X7 han sido inicializados con los valores 0 y 8N respectivamente.

![[Pasted image 20250915113052.png]]

a) Determinar qué técnica de predicción de salto (no dinámica) generará la menor cantidad de demoras por flush instructions si N > 1. 

*Considerando el caso del procesador No optimizado para saltos*
Si consideramos demoras *POR FLUSH* debemos optar por la técnica de predicción de salto (No dinámica) TAKEN, **aunque** la penalidad es la misma dado que se sabe a dónde se va a saltar recién en la etapa de MEMORY.

*Considerando el caso del procesador Optimizado para saltos*
En este caso voy a tener el mismo resultado, es decir una penalidad de la misma longitud pero, en este caso, tengo 1 ciclo de penalidad tanto para el flush como para saber a dónde debo saltar.

b) Analizar la ejecución del código considerando que el resultado y la dirección del salto se determinan en la etapa de decodificación (ID) y se aplican en la etapa de ejecución (EX) y que no hay hazards de datos (Figura 4.61 de “Computer organization and design - ARM edition” Patterson & Hennessy).

![[Pasted image 20250915182118.png]]

## Ejercicio 9
Asumiendo que los saltos condicionales son perfectamente predichos (elimina el riesgo de hazard de control), si *se tiene una única unidad de memoria para instrucciones y datos*, existe un riesgo estructural cada vez que se necesita leer una instrucción en el mismo ciclo en que otra instrucción accede a un dato. Dados el siguiente fragmento de código de instrucciones LEGv8:

![[Pasted image 20250915182203.png]]

a) Asumiendo forwarding stall (el cual solo elimina los hazards de datos), mostrar gráficamente el orden de ejecución del programa en el pipeline. Identificar dónde se generan los Hazards estructurales. 

![[Pasted image 20250915184107.png]]

*HAZARD* 🐊: Tenemos que agregar si o si stalls donde están ya que podemos ver que
- En el *ciclo 4*, STUR está utilizando MEM para acceder, mientras que en ese mismo clock se intentaría fetchear CBZ.
- En el *ciclo 5*, LDUR está utilizando MEM para sacar dato, mientras que en ese mismo clock se intentaría fetchear CBZ.

b) Anteriormente, se vio que los riesgos de datos se pueden eliminar agregando instrucciones nop en el código. ¿Se puede hacer lo mismo con este hazard? ¿Por qué?

No se puede hacer lo mismo dado que un NOP es una instrucción que básicamente no altera el funcionamiento del programa, pero justamente al ser una instrucción se necesitaría fetchearla! Por lo tanto no nos salvamos del STALL 🐊.

## Ejercicio 10
El segmento de código dado se ejecuta en el procesador LEGv8 con pipeline de la figura (sin forwarding stall). Analizando el estado del procesador en el ciclo de clock número 5 (considerando que el fetch de la primera instrucción se realiza en el ciclo número 1), responder:
![[Pasted image 20250915190037.png]]

a) ¿Qué valor hay a la salida del PC? 
	0x110 dado que 0x100 + 16
b) ¿Qué valor hay en la entrada “Write register” del bloque Registers? 
	Valor 1 pues en el 5to clock se escribe en X9
c) ¿Qué operación realiza la ALU? Calcula la dirección X2 + #0
d) Completar el siguiente cuadro con los valores que tienen las señales de control:

| Reg2Loc | ALUSrc | MemtoReg | RegWrite | MemRead | MemWrite | Branch |
| ------- | ------ | -------- | -------- | ------- | -------- |:------:|
| 0       | 1      | 0        | 0        | 0       | 1        |   0    |
