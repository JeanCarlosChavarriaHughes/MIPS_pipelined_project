# MIPS_pipelined_project
This repository contains code and a report of the last project in computer architecture course: **Pipelined segmented procesor**.

## Introduccion

El propósito de este laboratorio consiste en brindar una metodología de trabajo en la que se permita segmentar el proceso de diseño e implementación de un proyecto de software en diferentes etapas, y además, delegar diferentes responsabilidades entre cada uno de los autores para simplificar el desarrollo de las subtareas.

Se busca diseñar e implementar un procesador con pipeline de cinco etapas para dos registros de 16 bits, utilizando el lenguaje de descripción de hardware Verilog. Las etapas definidas para el procesador son: *Instruction Fetch (IF)*, *Instruction Decode (ID)*, *Execution (EX)*, *Memory (MEM)* y *Write Back (WB)*.

Finalmente, se busca dar a conocer una posible opción de organización temporal para que el proyecto cumpla con especificaciones de fechas de entrega y diferentes hitos, para lo cual se diseña un esquema propuesto y luego se contrasta con el desarrollo real del proyecto.

A modo de resumen, se logró concluir con el laboratorio de manera satifasctoria mediante la implementación de diferentes módulos en Verilog, y su respectivo plan de pruebas y cronograma de tareas. Además, se desarrollaron efectivamente habilidades en las áreas de diseño, modelado y verificación de hardware en Verilog de circuitos digitales.


## Funcionalidad
En el directorio Codes/Verilog_Testbenches, adicional a todos los bancos de pruebas que se realizaron para verificar el funcionamiento del diseño, se agregó un makefile para ejecutar todas las pruebas.

La sintaxis para ejecutar las pruebas es la siguiente:
```makefile
	make <Prueba_a_realizar>
```	

Reemplazando *<Prueba_a_realizar>* con:
	
* `Decoder`, si se quiere ejecutar la prueba al Instruction Decoder, encargado de decodificar todas las instrucciones que recibe.
* `ALU_all`, si se quiere ejecutar la prueba a los módulos ALU y ALU control, encargados de realizar los cálculos aritméticos.
* `Ram_all`, si se quiere ejecutar la prueba a la memoria RAM.
* `Forward`, si se quiere ejecutar la prueba al módulo encargado de controlar los forwards.
* `BTaken`, si se quiere ejecutar la prueba al módulo encargado de definir si los branches son tomados o no
* `Cpu`, si se quiere ejecutar la prueba al CPU, que incluye todos los módulos implementados y conectados adecuadamente.

El documento [Reporte](./Reporte.pdf) se encuentra el reporte que incluye todas las especificaciones del diseño realizado, así como de las diferentes pruebas que se realizaron para asegurar el correcto funcionamiento del procesador.

	
