# 🛢️ petroleum-production-sql-analysis

Análisis exploratorio, limpieza de datos, métricas operativas y consultas avanzadas (*Window Functions*) sobre producción hidrocarburífera en SQL Server / MySQL y Power BI.

---

## 📊 Análisis de Producción Petrolera y Tendencias Históricas en SQL

Este repositorio contiene un proyecto analítico *End-to-End* enfocado en el procesamiento, limpieza, análisis exploratorio avanzado y seguimiento de series temporales sobre la producción de petróleo y gas por activo.

---

## 🎯 Problema de Negocio (Business Case)

Se requiere visibilidad sobre el rendimiento histórico de la producción hidrocarburífera. El objetivo principal es:
* Identificar variaciones mes a mes (**MoM**) y el avance acumulado anual (**YTD**) de cada campo.
* Evaluar el **GOR** (*Gas-Oil Ratio*) para clasificar la madurez/característica de explotación de los pozos.
* Segmentar los activos con mayor volumen de extracción mediante consultas analíticas y *Window Functions* en SQL.

---

## 🛠️ Tecnologías y Herramientas

* **Lenguaje SQL:** T-SQL (SQL Server) / MySQL
* **Técnicas y Funciones Clave:** 
  * **Window Functions:** `LAG`, `SUM() OVER`, `DENSE_RANK`, `ROW_NUMBER`
  * **Control y Expresiones:** `CTE` (`WITH`), `CASE WHEN`, `NULLIF`, `ROUND`
  * **Agregaciones & Subconsultas:** `GROUP BY`, `HAVING`, Subconsultas Escalables
* **Herramientas de Gestión:** SQL Server Management Studio (SSMS) / MySQL Workbench
* **Visualización:** Power BI / Excel

---

<img width="1116" height="635" alt="dashboard_preview" src="https://github.com/user-attachments/assets/ad780def-de98-4f9a-8ebf-ed2b21c307ec" />

---

## 📁 Estructura del Repositorio

```text
├── sql/
│   ├── 01_limpieza_y_desduplicacion.sql       # Script de ingesta, tipado y desduplicación con CTE + ROW_NUMBER
│   ├── 02_analisis_exploratorio_y_metricas.sql # Consultas de negocio, GOR, CASE WHEN y subconsultas escalares
│   └── 03_window_functions_y_tendencias.sql    # Análisis MoM, YTD y rankings con Window Functions
├── dashboard/
│   └── dashboard_preview.png                  # Captura ejecutiva del tablero en Power BI
└── README.md                                  # Documentación general del proyecto
