from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
import uuid

app = FastAPI(title="API de Pólizas de Seguro", version="1.0.0")

# Permitir CORS para comunicación de clientes web y móviles
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Poliza(BaseModel):
    id: str
    codigo: str
    cliente: str
    tipoSeguro: str
    fechaInicio: str
    fechaVencimiento: str
    valorAsegurado: float

# Base de datos en memoria inicializada con datos demo
polizas_db = [
    {
        "id": "1",
        "codigo": "POL-2026-001",
        "cliente": "Alejandro Gomez",
        "tipoSeguro": "Vida",
        "fechaInicio": "2026-01-01",
        "fechaVencimiento": "2027-01-01",
        "valorAsegurado": 150000.0
    },
    {
        "id": "2",
        "codigo": "POL-2026-002",
        "cliente": "Maria Lopez",
        "tipoSeguro": "Auto",
        "fechaInicio": "2026-02-15",
        "fechaVencimiento": "2027-02-15",
        "valorAsegurado": 45000.0
    }
]

@app.get("/api/polizas", response_model=List[Poliza])
def get_polizas():
    return polizas_db

@app.post("/api/polizas", response_model=Poliza, status_code=201)
def create_poliza(poliza: Poliza):
    poliza_dict = poliza.model_dump() if hasattr(poliza, "model_dump") else poliza.dict()
    poliza_dict["id"] = str(uuid.uuid4())
    polizas_db.append(poliza_dict)
    return poliza_dict

@app.put("/api/polizas/{poliza_id}", response_model=Poliza)
def update_poliza(poliza_id: str, poliza: Poliza):
    for idx, p in enumerate(polizas_db):
        if p["id"] == poliza_id:
            updated_dict = poliza.model_dump() if hasattr(poliza, "model_dump") else poliza.dict()
            updated_dict["id"] = poliza_id  # Preservar el ID original
            polizas_db[idx] = updated_dict
            return updated_dict
    raise HTTPException(status_code=404, detail="Póliza no encontrada")

@app.delete("/api/polizas/{poliza_id}", response_model=Poliza)
def delete_poliza(poliza_id: str):
    for idx, p in enumerate(polizas_db):
        if p["id"] == poliza_id:
            return polizas_db.pop(idx)
    raise HTTPException(status_code=404, detail="Póliza no encontrada")

if __name__ == "__main__":
    import uvicorn
    # Escucha en todas las interfaces para accesibilidad externa
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
