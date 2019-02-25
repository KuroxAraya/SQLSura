USE [TH_AD]
GO

/****** Object:  StoredProcedure [dbo].[VALIDAESTADOVAC]    Script Date: 02/25/2019 16:33:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[VALIDAESTADOVAC]
AS

	BEGIN TRANSACTION
		UPDATE 
			historicoVac
		SET 
			historicoVac.VALIDO = 'I'
		FROM
			historicoVac,
			canceladasVac
		WHERE 
			RIGHT('0000000000' + ISNULL(historicoVac.RUT, N''), 10) = RIGHT('0000000000' + ISNULL(canceladasVac.RUT, N''), 10)
			AND historicoVac.INI  = canceladasVac.INI
			AND historicoVac.DIAS_DUR  = canceladasVac.DIAS_DUR
		    
		UPDATE
			historicoVacPROC
		SET 
			historicoVacPROC.VALIDO = 'I'
		FROM
			historicoVacPROC,
			canceladasVac
		WHERE 
			historicoVac.IDHIST  = historicoVacPROC.IDHIST
			AND historicoVac.VALIDO = 'I'
	COMMIT;

GO


