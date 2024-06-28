from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select
from alchemy.connector import get_db
from alchemy.models import *

app = FastAPI()

@app.get("/usuarios/")
def obtener_usuarios(db: Session = Depends(get_db)):
    try:
        usuarios = db.query(Usuario).all()
        return {"usuarios": usuarios}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener usuarios: {str(e)}")

@app.get("/samples10/")
def obtener_samples_altos(db: Session = Depends(get_db)):
    try:
        query = (
            select(
                Maquina.nombre.label('nombre_maquina'),
                Sample.nombre.label('nombre_sample'),
                Sample.valor
            )
            .join(Maquina.samples)
            .where(Sample.valor > 10)
        )
        resultados = db.execute(query).fetchall()

        # Ensure the results are properly formatted as dictionaries
        datos = [{"nombre_maquina": r.nombre_maquina, "nombre_sample": r.nombre_sample, "valor": r.valor} for r in resultados]

        return {"datos": datos}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener datos: {str(e)}")


@app.get("/sampleslimit/")
def obtener_samples_altos(db: Session = Depends(get_db)):
    try:
        query = (
            select(
                Sample.nombre.label('nombre_sample'),
                Sample.valor
            )
            .limit(2)
            .where(Sample.valor > 10)
        )
        resultados = db.execute(query).fetchall()

        # Ensure the results are properly formatted as dictionaries
        datos = [{"nombre_sample": r.nombre_sample, "valor": r.valor} for r in resultados]

        return {"datos": datos}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener datos: {str(e)}")

@app.post("/samples/")
def crear_sample(db: Session = Depends(get_db)):
    try:
        nuevo_sample = Sample(nombre="Sample 1", valor=15, id_maquina=1)
        db.add(nuevo_sample)
        db.commit()
        db.refresh(nuevo_sample)
        return {"message": "Sample creado exitosamente", "sample": nuevo_sample}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al crear sample: {str(e)}")
