MIPS Pipeline + Decodificador en Python

Este proyecto implementa un procesador MIPS de 5 etapas en arquitectura pipeline, junto con un decodificador de instrucciones en Python que genera el archivo .mem para inicializar la memoria de instrucciones del procesador.
Fue desarrollado como proyecto final para la materia Arquitectura de Computadoras.

Descripción General
El sistema completo está formado por dos componentes principales:
1. Procesador MIPS Pipeline (Verilog)
Incluye las 5 etapas clásicas:

IF – Instruction Fetch
ID – Instruction Decode
EX – Execution / ALU
MEM – Memory Access
WB – Write Back

Incluye:
Banco de registros
ALU
Módulos de control
Memoria de instrucciones
Memoria de datos
Manejo de señales pipeline (IF/ID, ID/EX, EX/MEM, MEM/WB)
Soporte para branch y saltos
Multiplexores y forwarding (si aplica)

2. Decodificador MIPS (Python)
Un script en Python que:

Traduce instrucciones en ensamblador al formato binario MIPS.
Genera un archivo program_memory.mem compatible con $readmemb de Verilog.
Soporta el conjunto extendido especificado por el proyecto:

R-Type
ADD, SUB, AND, OR, SLT
I-Type
Aritméticas/lógicas: ADDI, ANDI, ORI, XORI, SLTI
Control de flujo: BEQ
Memoria: LW, SW
J-Type
J

Estructura del Proyecto
/Proyecto-MIPS
│
├── /src_verilog
│   ├── Micro_P.v
│   ├── IF.v
│   ├── ID.v
│   ├── EX.v
│   ├── MEM.v
│   ├── WB.v
│   ├── ALU.v
│   ├── Control.v
│   ├── RegisterFile.v
│   ├── DataMemory.v
│   ├── InstructionMemory.v
│   ├── PipelineRegisters/
│   │   ├── IF_ID.v
│   │   ├── ID_EX.v
│   │   ├── EX_MEM.v
│   │   ├── MEM_WB.v
│   └── ...
│
├── /python_decoder
│   ├── decoder.py
│   ├── instrucciones.txt
│   └── program_memory.mem   (archivo generado)
│
├── /docs
│   ├── Reporte.pdf
│   ├── Diagramas.png
│   └── Capturas_ModelSim/
│
└── README.md

Cómo Ejecutar el Proyecto
1. Generar el archivo .mem con el decodificador
python decoder.py

Esto generará:
program_memory.mem

2. Cargar el pipeline en ModelSim
Abrir ModelSim
Crear un nuevo proyecto
Importar todos los módulos Verilog
Asegurar que InstructionMemory.v tenga:

initial begin
    $readmemb("program_memory.mem", memory);
end

Compilar
Simular Micro_P.v
Agregar señales al Wave:
Program Counter
Instruction fetched
Señales de control
Resultados de ALU
Memoria de datos
Banco de registros
Programa de Prueba

El proyecto incluye un programa ensamblador que:

Utiliza operaciones aritméticas
Usa comparaciones (SLT, BEQ)
Accede a memoria (LW, SW)
Usa saltos (J)
Implementa un algoritmo no trivial
Objetivo del Proyecto

Demostrar:

Entendimiento de la arquitectura MIPS
Implementación correcta del pipeline
Funcionamiento real del flujo IF → WB
Capacidad de generar programas propios con el decodificador
Manejo de memoria, saltos, comparaciones y lógica

Tecnologías Utilizadas:

Verilog HDL – Diseño hardware
ModelSim – Simulación del procesador
Python 3 – Generación de instrucciones binarias
GitHub – Control de versiones

