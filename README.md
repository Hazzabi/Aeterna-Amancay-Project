```markdown
# Aeterna Amancay - Proyecto Intermodular ASIR 1º

**Infraestructura TI completa para una empresa aeroespacial**

[Web en producción](https://aeterna-amancay.netlify.app/)
[Repositorio GitHub](https://github.com/Hazzabi/Aeterna-Amancay-Project)

---

## La Empresa

**Aeterna Amancay** es una compañía aeroespacial con identidad andina que conecta la tierra con el cosmos. Diseña, integra y opera misiones de órbita baja para instituciones públicas, programas científicos y organizaciones que necesitan observar, medir y proteger el territorio desde el cielo.

La empresa opera desde dos sedes:

| Sede | Ubicación | Función | Empleados |
| :--- | :--- | :--- | :--- |
| **Alborada** | Madrid | Centro de pensamiento, estrategia y administración | 25 |
| **El Santuario** | Afueras de Madrid | Centro de operaciones técnicas y ejecución | 50 |

Los **75 empleados** —denominados **Almas**— se distribuyen en nueve departamentos: Visión y Armonía, Eco del Mercado, Taller de Formas, Guardianes del Éter, Vuelo Astral, Vigía del Cosmos, Laboratorio de Alquimia y Logística de la Tierra.

**Servicios principales:**
- Integración y puesta en órbita de satélites
- Telemetría y lectura del territorio en tiempo real
- Custodia operativa continua de misiones activas

**Web del proyecto:** [https://aeterna-amancay.netlify.app/](https://aeterna-amancay.netlify.app/)

---

## Estructura del Proyecto

```
Aeterna-Amancay-Project/
│
├── 01_Redes_y_Conectividad/        # Módulo 0370 - Planificación y Administración de Redes
│   ├── 02_Packet_tracer/           # Archivo .pkt con la topología completa
│   ├── 03_Configuraciones/         # Comandos de routers, switches y documentación
│   └── Documentación de Red
│
├── 02_Base_de_Datos/               # Módulo 0372 - Gestión de Bases de Datos
│   ├── 02_Scripts_sql/             # Scripts de creación, inserción y consultas
│   ├── 03_Diagramas/               # Diagrama Entidad-Relación
│   └── Memoria de Base de Datos
│
├── 03_Sistemas_e_Identidad/        # Módulo 0369 - Implantación de Sistemas Operativos
│   ├── SRV-AD-AMANCAY (Windows Server 2022 + Active Directory)
│   ├── DB-SATELITES (Ubuntu Server + PostgreSQL)
│   └── BASTION-AMANCAY (Ubuntu Server + SSH Hardening)
│
├── 04_Lenguaje_de_Marcas/          # Módulo 0373 - Lenguajes de Marcas
│   ├── Web completa (HTML, CSS, JS)
│   ├── assets/                     # Imágenes, fondos, logo
│   ├── datos/                      # XML y XSD de validación
│   └── README del módulo
│
├── 05_Hardware/                    # Módulo 0371 - Fundamentos de Hardware
│   └── Infraestructura Hardware
│
└── 06_Cloud/                       # Módulo Optativo - Computación en la Nube
    └── Arquitectura AWS
```

---

## Módulos del Proyecto

### 0369 - Implantación de Sistemas Operativos
Despliegue de 3 servidores: controlador de dominio Windows Server 2022 con Active Directory, DNS, DHCP y WDS; servidor de base de datos Ubuntu con PostgreSQL; y Bastion Host securizado con SSH, UFW y Fail2Ban. Gestión automatizada de 75 usuarios mediante PowerShell.

### 0370 - Planificación y Administración de Redes
Topología completa en Cisco Packet Tracer con 2 routers, 2 switches multicapa y 4 switches de acceso. VLANs por departamento, enrutamiento OSPF, redundancia HSRP, ACLs de seguridad y servicios DNS y DHCP.

### 0372 - Gestión de Bases de Datos
Base de datos PostgreSQL con 22 tablas en Tercera Forma Normal. Cuatro bloques funcionales: seguridad, facturación, operaciones espaciales e inventario. Scripts SQL de creación, inserción de datos de prueba y consultas de verificación.

### 0373 - Lenguajes de Marcas
Portal web "Espejo de Obsidiana" con diseño místico-corporativo. HTML5, CSS3 con efecto parallax estelar, JavaScript para consumo de datos. Validación de datos con XML y XSD.

### 0371 - Fundamentos de Hardware
Análisis de necesidades hardware para las dos sedes: servidores, equipos cliente, almacenamiento NAS con RAID, SAI, equipamiento de red Cisco y componentes aeroespaciales.

### CMO - Computación en la Nube
Arquitectura de migración híbrida a AWS: EC2 para PostgreSQL y Bastion, S3 con Glacier para backups, IAM y KMS para seguridad, VPN Site-to-Site y estimación de costes.

---

## Tecnologías Utilizadas

| Categoría | Tecnologías |
| :--- | :--- |
| **Sistemas Operativos** | Windows Server 2022, Ubuntu Server 22.04, Windows 11 Pro |
| **Virtualización** | Oracle VirtualBox |
| **Redes** | Cisco Packet Tracer, OSPF, HSRP, VLANs, ACLs |
| **Base de Datos** | PostgreSQL, SQL (DDL, DML, DCL) |
| **Desarrollo Web** | HTML5, CSS3, JavaScript, XML, XSD |
| **Cloud** | Amazon Web Services (EC2, S3, IAM, KMS, CloudWatch) |
| **Control de Versiones** | Git, GitHub |

---

## Autora

**Gabriela Estefany Garcia Martinez**

1º ASIR - Administración de Sistemas Informáticos en Red

Proyecto Intermodular | Mayo 2026
