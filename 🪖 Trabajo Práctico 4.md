# Teórico
## 🪖 Forwarding
Únicas formas de hacer *forwarding*:
- Desde la salida de la *ALU* hacia OPERANDOS.
- Desde la salida de *MEMORY* hacia OPERANDOS.
- *CASO PARTICULAR*: Buscamos un dato de la memoria y lo necesito usar en la siguiente instrucción. *Necesariamente* tengo que esperar 1 ciclo de clock para recién *forwardear*.

## 🐊 Hazzard vs Dependencias
- *Dependencias de datos*: Por cómo escribo el código tengo una dependencia entre distintos operandos que voy utilizando. *Pej: Este X2 usado en línea 2 depende de X2 almacenado en línea 1*.

- *Hazzard*: Causado por una dependencia en algún tipo de Hardware. Se resuelven mediante forwarding. 
# Ejercicio 1
En un microprocesador con tres etapas de pipeline: *S1 -> S2 -> S3* , con tiempos de ejecución *T1 = T3 = T y T2 = 3T.*

![[Pasted image 20250910172324.png]]

*a) ¿Cuál de los tres segmentos o etapas causa la congestión? (el cuello de botella)*

- De los tres segmentos o etapas la que causa congestión (cuello de botella) es la *etapa 2*

*b) Asumiendo que el segmento problemático se puede dividir en dos etapas consecutivas, ninguna de ellas con duración menor que T, ¿cuál sería la mejor partición posible? ¿Cuál sería el período de clock resultante para este nuevo pipeline de 4 etapas? *

- La mejor partición posible sería *1.5T* cada una de esas etapas por lo tanto el período de clock resultante para este nuevo pipeline de 4 etapas sería de *1.5T*

*c) Asumiendo que el segmento problemático se puede dividir en varias etapas consecutivas de duración T, ¿cuál es el período de clock del microprocesador? ¿Cuál es el tiempo de ejecución entre instrucciones?*

- El periodo de clock del microprocesador sería de *T*
- El tiempo de ejecución entre instrucciones sería de *T*

# Ejercicio 2
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

*d) Si un microprocesador con pipeline ejecuta 3 instrucciones consecutivas ¿cuál es la ganancia de velocidad de un procesad\text{Ganancia de velocidad} = \frac{109ns * 3}{(40ns * 5)+ 2*40} = 1.168 or con pipeline respecto de uno sin pipeline? ¿Y si se ejecutan 1000 instrucciones consecutivas?*

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

# Ejercicio 4
Dados los siguientes fragmentos de código de instrucciones LEGv8:
![[Pasted image 20250910222823.png]]
*a) Analizar en el código las dependencias de datos. En cada caso indicar: los números de las instrucciones involucradas y el operando en conflicto.*

## Código A
| Dependencia de tipo | Números de instrucciones involucradas | Operando en conflicto |
| ------------------- | ------------------------------------- | --------------------- |
| Dato                | 1,2                                   | X6                    |

## Código B

| Dependencia de tipo | Números de instrucciones involucradas | Operando en conflicto |
| ------------------- | ------------------------------------- | --------------------- |
| Dato                | 1,2                                   | X10                   |
| Dato                | 1,3                                   | X10                   |

## Código C

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