-- ============================================================
-- Proyecto: Análisis de Producción Petrolera
-- Script: 01_limpieza_y_desduplicacion.sql
-- Objetivo: Eliminar registros duplicados de la tabla base
-- ============================================================

WITH CTE_Duplicados AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY anio, mes, activo, produccion_crudo 
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM datos
)
DELETE FROM CTE_Duplicados WHERE rn > 1;
