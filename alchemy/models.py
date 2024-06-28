# models.py
from sqlalchemy import Column, Integer, String, Boolean, Float, ForeignKey
from sqlalchemy.orm import relationship
from alchemy.connector import Base

class Depuradora(Base):
    __tablename__ = 'depuradora'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, index=True)
    ubicacion = Column(String)
    capacidad = Column(Integer)

    maquinas = relationship("Maquina", back_populates="depuradora")
    usuarios = relationship("Usuario", back_populates="depuradora")

class Maquina(Base):
    __tablename__ = 'maquina'
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    nombre = Column(String, index=True)
    encendida = Column(Boolean)
    id_depuradora = Column(Integer, ForeignKey('depuradora.id'))

    depuradora = relationship("Depuradora", back_populates="maquinas")
    samples = relationship("Sample", back_populates="maquina")
    grupo_lectura = relationship("GrupoLectura", back_populates="maquina")
    grupo_escritura = relationship("GrupoEscritura", back_populates="maquina")

class Sample(Base):
    __tablename__ = 'sample'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, index=True)
    valor = Column(Float)
    id_maquina = Column(Integer, ForeignKey('maquina.id'))

    maquina = relationship("Maquina", back_populates="samples")

class Indicador(Base):
    __tablename__ = 'indicador'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, index=True)

class GrupoLectura(Base):
    __tablename__ = 'grupoLectura'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, index=True)
    id_maquina = Column(Integer, ForeignKey('maquina.id'))

    maquina = relationship("Maquina", back_populates="grupo_lectura")
    grupo_lind = relationship("GrupoLind", back_populates="grupo_lectura")

class GrupoEscritura(Base):
    __tablename__ = 'grupoEscritura'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, index=True)
    id_maquina = Column(Integer, ForeignKey('maquina.id'))

    maquina = relationship("Maquina", back_populates="grupo_escritura")
    grupo_eind = relationship("GrupoEind", back_populates="grupo_escritura")

class GrupoLind(Base):
    __tablename__ = 'grupoLind'
    id_grupo = Column(Integer, ForeignKey('grupoLectura.id'), primary_key=True)
    id_indicador = Column(Integer, ForeignKey('indicador.id'), primary_key=True)
    nombre = Column(String, index=True)

    grupo_lectura = relationship("GrupoLectura", back_populates="grupo_lind")
    indicador = relationship("Indicador")

class GrupoEind(Base):
    __tablename__ = 'grupoEind'
    id_grupo = Column(Integer, ForeignKey('grupoEscritura.id'), primary_key=True)
    id_indicador = Column(Integer, ForeignKey('indicador.id'), primary_key=True)
    nombre = Column(String, index=True)

    grupo_escritura = relationship("GrupoEscritura", back_populates="grupo_eind")
    indicador = relationship("Indicador")

class Usuario(Base):
    __tablename__ = 'usuario'
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    username = Column(String, index=True)
    nombre = Column(String)
    email = Column(String, unique=True)
    disabled = Column(Boolean)
    password = Column(String)
    id_depuradora = Column(Integer, ForeignKey('depuradora.id'))

    depuradora = relationship("Depuradora", back_populates="usuarios")
