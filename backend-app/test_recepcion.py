import pytest
from app import app # Se importa la app principal de Flask

@pytest.fixture
def client():
    # Configura la app para testing
    app.config['TESTING'] = True
    # Crea un cliente de prueba
    with app.test_client() as client:
        yield client

def test_recepcion_producto_valida(client):
    # Simula el envio de SKU y numero_oc validos
    response = client.post('/recepcion', json={
        "sku": "SKU12345",
        "numero_oc": "OC-67890"
    })

    # Verifica que la respuesta sea exitosa
    assert response.status_code == 200
    data = response.get_json()

    # Verifica que la API retorne estado OK
    assert data['status'] == 'success'
    assert data['data'] is not None

def test_recepcion_producto_invalido(client):
    # Simula el envio de SKU y numero_oc invalidos
    response = client.post('/recepcion', json={
        "sku": "SKU1921",
        "numero_oc": "OC-00000"
    })

    # Verifica que la respuesta sea 404 (no encontrado)
    assert response.status_code == 404
    data = response.get_json()

    # Verifica que la API retorne estado ERROR
    assert data['status'] == 'error'
    assert data['message'] == 'Producto no encontrado'