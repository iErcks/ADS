-- Crear la base de datos
CREATE DATABASE FinanzasApp;
USE FinanzasApp;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Adeudos
-- Tabla CategoriasAdeudos
CREATE TABLE CategoriasAdeudos (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Modificación de la tabla Adeudos para usar la tabla CategoriasAdeudos
CREATE TABLE Adeudos (
    id_adeudo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado ENUM('pendiente', 'pagado') DEFAULT 'pendiente',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES CategoriasAdeudos(id_categoria) ON DELETE CASCADE
);


-- Tabla Ingresos
C-- Tabla CategoriasIngresos
CREATE TABLE CategoriasIngresos (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Modificación de la tabla Ingresos para usar la tabla CategoriasIngresos
CREATE TABLE Ingresos (
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_registro DATE NOT NULL,
    fuente VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES CategoriasIngresos(id_categoria) ON DELETE CASCADE
);


-- Tabla Deudas
CREATE TABLE Deudas (
    id_deuda INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE NOT NULL,
    entidad_acreedora VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla Pagos
CREATE TABLE Pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_deuda INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE NOT NULL,
    FOREIGN KEY (id_deuda) REFERENCES Deudas(id_deuda) ON DELETE CASCADE
);

-- Tabla Tarjetas
CREATE TABLE Tarjetas (
    id_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    limite_credito DECIMAL(10, 2) NOT NULL,
    fecha_corte DATE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla PagosTarjetas
CREATE TABLE PagosTarjetas (
    id_pago_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    id_tarjeta INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE NOT NULL,
    FOREIGN KEY (id_tarjeta) REFERENCES Tarjetas(id_tarjeta) ON DELETE CASCADE
);

-- Tabla Inversiones
CREATE TABLE Inversiones (
    id_inversion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_inversion VARCHAR(50) NOT NULL,
    monto_invertido DECIMAL(10, 2) NOT NULL,
    fecha_adquisicion DATE NOT NULL,
    tasa_rendimiento DECIMAL(5, 2),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla Presupuestos
CREATE TABLE Presupuestos (
    id_presupuesto INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    limite_gasto DECIMAL(10, 2) NOT NULL,
    gasto_actual DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla Tendencias
CREATE TABLE Tendencias (
    id_tendencia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    tipo_tendencia ENUM('gastos', 'ingresos', 'ahorro') NOT NULL,
    datos_tendencia JSON NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla EducacionFinanciera
CREATE TABLE EducacionFinanciera (
    id_contenido INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    contenido TEXT NOT NULL
);

-- Tabla SaldoQuincenal
CREATE TABLE SaldoQuincenal (
    id_saldo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_registro DATE NOT NULL,
    configuracion JSON,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);
