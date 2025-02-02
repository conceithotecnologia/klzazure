
create procedure [dbo].[prc_limpa_Duplicados_cd]


as

------------------------------------------------------------------------------------------------
-- verfica duplicidade - Mendes 26/05/2021
------------------------------------------------------------------------------------------------
--prepara copia da tabela cd_geral de registro que n�o s�o duplicado na tabela  duplicate_table
SELECT DISTINCT *
INTO duplicate_table
FROM [dbo].[CD_Geral]
GROUP BY Company,Business,ID_transacao,Id,Nome,Email,Data_Transacao,Data_Ultimo_Status,Tipo,
Valor,Opera��o,Metodo,Pedido,[Status],Tid,Uuid,Saldo,Empresa,Liga,Valor_liga,Times,Valor_Times,Transacao_Relacionada
HAVING COUNT(ID_transacao) > 1

--deleta registro duplicado na tabela CD_Geral
DELETE [dbo].[CD_Geral]
WHERE ID_transacao
IN (SELECT ID_transacao
FROM duplicate_table)
-- gera insert dos registro originais da tabela duplicate_table para CD_Geral
INSERT [dbo].[CD_Geral]
SELECT *
FROM duplicate_table

--apaga tabela temporaria
DROP TABLE duplicate_table




GO