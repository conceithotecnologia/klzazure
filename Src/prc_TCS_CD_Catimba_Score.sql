SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[prc_TCS_CD_Catimba_Score]

-------------------------------
--- Parametro xxxx
-------------------------------
--@xxx varchar(100)
as

insert into dbo.CD_Geral(Company,Business,ID_transacao,Id,Nome,Email,Data_Transacao,Data_Ultimo_Status,
      Tipo,Valor,[Opera��o],Metodo,Pedido,[Status],Tid,Uuid ,saldo,Empresa,Liga,Valor_Liga,Times,Valor_Times,Transacao_Relacionada)

select 'Catimba' as Company,
	'Catimba_Score' as Business, 
	  substring(left(replace(replace(replace( replace(cast([Data_Transa��o] as varchar(30)),'-',''),'T',''),':',''),'.',''), 16), 3, 16)+
   dbo.strzero(cast(cast(id as varchar(6)) as integer), 6) as IDTransacao,
	Cast( Id as Varchar(6)) as Id,
	Cast (Nome as varchar(50)) as Nome ,
	Cast (Email as varchar(50)) as Email,
	convert(varchar,([Data_Transa��o]),120)as [Data Transa��o] ,
	convert(varchar,([Data_�ltimo_Status]),120) as [Data �ltimo Status],
    Cast (Tipo as varchar(20)) as Tipo, 
	case when cast([Valor] as varchar(50)) = '-' then 0 else cast(cast([Valor] as varchar(50)) as float) end as Valor,
	CAST(case when cast(Opera��o as varchar(20)) = 'Adi��o de cr�dito'  then 'Adi��o de Cr�dito'else Opera��o end as varchar(25)) as Operacao, 
	CAST(M�todo as varchar(20)) as Metodo, 
	Cast (Pedido as varchar(40)) as Pedido ,
	CAST([Status] as varchar(12)) as [Status],
	Cast(Tid as varchar(40)) as Tid, 
	Cast(Uuid as varchar(40)) as Uuid ,
	case when cast(Saldo as varchar(1)) = '-' or cast(Saldo as varchar(10)) = 'Depositado'  or cast( Saldo as varchar(13))='Premia��o' or Cast(Saldo as varchar(5))=''   then 0 else cast(cast(Saldo as varchar(50)) as numeric(18,2))  end as Saldo,  
	Cast(Empresa as varchar(20)) as Empresa,
	Cast(Liga as varchar(15)) as Liga,
	case when cast([Valor_Times] as varchar(50)) = '-' then 0 else cast(cast([Valor_Times] as varchar(50)) as numeric(18,2)) end as [Valor Times],
	case when Cast([Valor_da_Liga] as varchar(50)) = '-' then 0 else cast(cast([Valor_da_liga] as varchar(50)) as numeric(18,2))end as [Valor da Liga],
	case when cast(Times as varchar(50)) = '-' then 0 else cast(cast(Times as varchar(50))  as numeric(18,2)) end  as Times ,
	Cast([Transa��o_Relacionada] as varchar(30)) as [Transacao Relacionada]
    
	from dbo.TCS_CD_Catimba_Score
	
	where Cast([Status] as varchar(12)) = 'Completada';



-----------------------------------------------------------------------------------------------
-- drop tabela para ser usada em outro processo de importa��o 
------------------------------------------------------------------------------------------------
DROP TABLE TCS_CD_Catimba_Score

GO
