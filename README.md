# petroleum-production-sql-analysis
Análisis exploratorio, limpieza de datos y consultas avanzadas (Window Functions) sobre producción hidrocarburífera en SQL Server / MySQL y Power BI.
# 📊 Análisis de Producción Petrolera y Tendencias Históricas en SQL

Este repositorio contiene un proyecto analítico *End-to-End* enfocado en el procesamiento, limpieza y análisis avanzado de series temporales sobre la producción de petróleo y gas por activo.

## 🎯 Problema de Negocio (Business Case)
Se requiere visibilidad sobre el rendimiento histórico de producción hidrocarburífera. El objetivo principal es identificar variaciones mes a mes (MoM), evaluar el avance acumulado anual (YTD) de cada campo y segmentar los activos con mayor volumen de extracción mediante consultas optimizadas en SQL.

---

## 🛠️ Tecnologías y Herramientas
* **Lenguaje SQL:** T-SQL (SQL Server) / MySQL
* **Funciones Clave:** Window Functions (`LAG`, `SUM() OVER`, `DENSE_RANK`, `ROW_NUMBER`), CTEs (`WITH`), Agregaciones (`GROUP BY`)
* **Herramientas:** SQL Server Management Studio (SSMS) / MySQL Workbench
* **Visualización:** Power BI / Excel *(Próximamente)*

---

## 🧹 1. Limpieza y Modelado de Datos
Durante la ingesta de datos en formato raw, se resolvieron los siguientes desafíos estructurales:
1. **Manejo de Encoding y Formatos:** Corrección de la fila de encabezados duplicada e importación de caracteres especiales (`ï»¿AÑ'O`).
2. **Transformación de Tipos de Datos:** Conversión de columnas numéricas en formato texto con separadores de miles y comas a tipos `DECIMAL(15,2)` estandarizados.
3. **Eliminación de Registros Duplicados:** Aplicación de un CTE analítico con `ROW_NUMBER()` para desduplicar la tabla sin perder integridad de información.

```sql
WITH CTE_Duplicados AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY anio, mes, activo, produccion_crudo 
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM datos
)
DELETE FROM CTE_Duplicados WHERE rn > 1;
