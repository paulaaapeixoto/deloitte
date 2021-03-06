USE [NEWDESENV]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Documento] [varchar](14) NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fornecedor]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fornecedor](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Documento] [varchar](14) NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotaFiscal]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotaFiscal](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[ValorTotal] [decimal](10, 2) NULL,
	[CodigoCliente] [int] NULL,
	[Data] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotaFiscalProduto]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotaFiscalProduto](
	[CodigoNotaFiscalProduto] [int] IDENTITY(1,1) NOT NULL,
	[CodigoNota] [int] NOT NULL,
	[CodigoProduto] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoNotaFiscalProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produto](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Preco] [decimal](10, 2) NULL,
	[CodigoFornecedor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([Codigo], [Nome], [Documento]) VALUES (1, N'PAULA PEIXOTO', N'02459907044')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Fornecedor] ON 

INSERT [dbo].[Fornecedor] ([Codigo], [Nome], [Documento]) VALUES (1, N'COFORN', N'60023066000129')
INSERT [dbo].[Fornecedor] ([Codigo], [Nome], [Documento]) VALUES (2, N'TRANSCEF', N'36216969000141')
SET IDENTITY_INSERT [dbo].[Fornecedor] OFF
GO
SET IDENTITY_INSERT [dbo].[NotaFiscal] ON 

INSERT [dbo].[NotaFiscal] ([Codigo], [ValorTotal], [CodigoCliente], [Data]) VALUES (3, CAST(40.00 AS Decimal(10, 2)), 1, CAST(N'2020-11-23T08:16:05.423' AS DateTime))
INSERT [dbo].[NotaFiscal] ([Codigo], [ValorTotal], [CodigoCliente], [Data]) VALUES (5, CAST(4.00 AS Decimal(10, 2)), 1, CAST(N'2020-11-23T07:45:26.880' AS DateTime))
SET IDENTITY_INSERT [dbo].[NotaFiscal] OFF
GO
SET IDENTITY_INSERT [dbo].[NotaFiscalProduto] ON 

INSERT [dbo].[NotaFiscalProduto] ([CodigoNotaFiscalProduto], [CodigoNota], [CodigoProduto], [Quantidade]) VALUES (2, 3, 1, 8)
INSERT [dbo].[NotaFiscalProduto] ([CodigoNotaFiscalProduto], [CodigoNota], [CodigoProduto], [Quantidade]) VALUES (4, 5, 2, 2)
SET IDENTITY_INSERT [dbo].[NotaFiscalProduto] OFF
GO
SET IDENTITY_INSERT [dbo].[Produto] ON 

INSERT [dbo].[Produto] ([Codigo], [Nome], [Preco], [CodigoFornecedor]) VALUES (1, N'COCA COLA', CAST(5.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Produto] ([Codigo], [Nome], [Preco], [CodigoFornecedor]) VALUES (2, N'GUARANA', CAST(2.00 AS Decimal(10, 2)), 1)
SET IDENTITY_INSERT [dbo].[Produto] OFF
GO
ALTER TABLE [dbo].[NotaFiscal] ADD  CONSTRAINT [DF_NotaFiscal_Data]  DEFAULT (getdate()) FOR [Data]
GO
ALTER TABLE [dbo].[NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_NotaFiscal_Cliente] FOREIGN KEY([CodigoCliente])
REFERENCES [dbo].[Cliente] ([Codigo])
GO
ALTER TABLE [dbo].[NotaFiscal] CHECK CONSTRAINT [FK_NotaFiscal_Cliente]
GO
ALTER TABLE [dbo].[NotaFiscalProduto]  WITH CHECK ADD  CONSTRAINT [FK_NotaFiscalProduto_NotaFiscal] FOREIGN KEY([CodigoNota])
REFERENCES [dbo].[NotaFiscal] ([Codigo])
GO
ALTER TABLE [dbo].[NotaFiscalProduto] CHECK CONSTRAINT [FK_NotaFiscalProduto_NotaFiscal]
GO
ALTER TABLE [dbo].[NotaFiscalProduto]  WITH CHECK ADD  CONSTRAINT [FK_NotaFiscalProduto_Produto] FOREIGN KEY([CodigoProduto])
REFERENCES [dbo].[Produto] ([Codigo])
GO
ALTER TABLE [dbo].[NotaFiscalProduto] CHECK CONSTRAINT [FK_NotaFiscalProduto_Produto]
GO
ALTER TABLE [dbo].[Produto]  WITH CHECK ADD  CONSTRAINT [FK_Produtos_Fornecedores] FOREIGN KEY([CodigoFornecedor])
REFERENCES [dbo].[Fornecedor] ([Codigo])
GO
ALTER TABLE [dbo].[Produto] CHECK CONSTRAINT [FK_Produtos_Fornecedores]
GO
/****** Object:  StoredProcedure [dbo].[usp_Cliente_Buscar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Cliente_Buscar]
(
	@Codigo INT
)
AS
BEGIN

SELECT  [Codigo]
      ,[Nome]
      ,[Documento]
  FROM [dbo].[Cliente]  WHERE Codigo = @Codigo

END

GO
/****** Object:  StoredProcedure [dbo].[usp_Cliente_Listar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =========================================================================================================
-- Author: Paula
-- Description: Retorna uma lista de clientes
-- =========================================================================================================

CREATE PROCEDURE [dbo].[usp_Cliente_Listar]
AS
BEGIN TRY
	SET NOCOUNT ON;

SELECT [Codigo]
      ,[Nome]
      ,[Documento]
  FROM [dbo].[Cliente]

END TRY

BEGIN CATCH
	DECLARE @ErrorLine INT = ERROR_LINE();												-- Retorna o número da linha onde ocorreu o erro.
	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();								-- Retorna informações sobre a causa do erro.
	DECLARE @ErrorNumber INT = ERROR_NUMBER();											-- Retorna o número de identificação do erro.
	DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();							-- Retorna o nome da procedure ou trigger onde o erro ocorreu.
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();										-- Retorna um indicador numérico com a severidade do erro.
    DECLARE @ErrorState INT = ERROR_STATE();											-- Retorna o estado do erro.
	DECLARE @sp_schema SYSNAME = QUOTENAME(OBJECT_SCHEMA_NAME(@@PROCID));				-- Retorna o schema utilizado na procedure atual.
	DECLARE @sp_name SYSNAME = @sp_schema + '.' + QUOTENAME(OBJECT_NAME(@@PROCID));		-- Retorna o nome  utilizado na procedure atual.
	DECLARE @sp_ObjectID INT = OBJECT_ID(@sp_name);										-- Retorna a identificação única da procedure atual.
	DECLARE @msgErro NVARCHAR(2048);													-- Declara atributo para logar o erro.

	SET @msgErro = ''
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DA CONEXÃO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SERVIDOR: ' + @@SERVERNAME;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'BANCO DE DADOS: ' + DB_NAME();
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SYSTEM_USER: ' + ISNULL(SYSTEM_USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'USER: ' + ISNULL(USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SPID: ' + ISNULL(CONVERT(nvarchar, @@SPID), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'FUNÇÃO: ' + @sp_name;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DO ERRO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR NUMBER: ' + ISNULL(CONVERT(nvarchar, @ErrorNumber), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR PROCEDURE: ' + @ErrorProcedure;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR LINE: ' + ISNULL(CONVERT(nvarchar, @ErrorLine), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR MESSAGE: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + @ErrorMessage;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'PARÂMETROS:';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + 'Procedure sem parâmetros';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';

	IF(@ErrorNumber != 70000)															
	BEGIN																				
		EXEC xp_logevent 
		 @ErrorNumber		-- Loga um erro no eventviewer com a mensagem informado.
		,@msgErro			-- Loga um erro no eventviewer com a mensagem informado.
		,ERROR;				-- Loga um erro no eventviewer com a mensagem informado.
	END
	ELSE
	BEGIN
		EXEC xp_logevent	-- Loga uma informação no eventviewer com a mensagem informada.
		 @ErrorNumber		-- Loga uma informação no eventviewer com a mensagem informada.
		,@msgErro			-- Loga uma informação no eventviewer com a mensagem informada.
		,WARNING;			-- Loga uma informação no eventviewer com a mensagem informada.
	END;
			
	RAISERROR(					
		 60000				-- Retorna o erro para a chamador.
		,@ErrorMessage		-- Retorna o erro para a chamador.
		,@ErrorState		-- Retorna o erro para a chamador.
		)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscal_Atualizar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_NotaFiscal_Atualizar]
(
	@Codigo INT, 
	@ValorTotal decimal(10,2),
	@CodigoCliente INT,
	@Update bit output
)
AS
BEGIN

UPDATE [dbo].[NotaFiscal]
   SET [ValorTotal] = @ValorTotal
      ,[CodigoCliente] = @CodigoCliente
      ,[Data] = GETDATE()
 WHERE Codigo = @Codigo

IF @@ERROR = 0
    SET @Update = 1
ELSE SET @Update = 0
END

GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscal_Buscar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_NotaFiscal_Buscar]
(
	@Codigo INT
)
AS
BEGIN

SELECT  [Codigo]
      ,[ValorTotal]
      ,[CodigoCliente]
      ,[Data]
  FROM [dbo].[NotaFiscal]
  WHERE Codigo = @Codigo


END


GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscal_Excluir]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_NotaFiscal_Excluir]
(
	@CodigoNota INT,
	@Deleted bit output
)
AS
BEGIN

	DELETE FROM [dbo].[NotaFiscalProduto]	WHERE CodigoNota = @CodigoNota
	DELETE FROM [dbo].[NotaFiscal]	WHERE Codigo = @CodigoNota

IF @@ERROR = 0
    SET @Deleted = 1
ELSE SET @Deleted = 0
END


GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscal_Listar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =========================================================================================================
-- Author: Paula
-- Description: Retorna uma lista de notas fiscais
-- =========================================================================================================

CREATE PROCEDURE [dbo].[usp_NotaFiscal_Listar]
AS
BEGIN TRY
	SET NOCOUNT ON;

SELECT [Codigo]
      ,[ValorTotal]
      ,[CodigoCliente]
      ,[Data]
  FROM [dbo].[NotaFiscal]

END TRY

BEGIN CATCH
	DECLARE @ErrorLine INT = ERROR_LINE();												-- Retorna o número da linha onde ocorreu o erro.
	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();								-- Retorna informações sobre a causa do erro.
	DECLARE @ErrorNumber INT = ERROR_NUMBER();											-- Retorna o número de identificação do erro.
	DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();							-- Retorna o nome da procedure ou trigger onde o erro ocorreu.
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();										-- Retorna um indicador numérico com a severidade do erro.
    DECLARE @ErrorState INT = ERROR_STATE();											-- Retorna o estado do erro.
	DECLARE @sp_schema SYSNAME = QUOTENAME(OBJECT_SCHEMA_NAME(@@PROCID));				-- Retorna o schema utilizado na procedure atual.
	DECLARE @sp_name SYSNAME = @sp_schema + '.' + QUOTENAME(OBJECT_NAME(@@PROCID));		-- Retorna o nome  utilizado na procedure atual.
	DECLARE @sp_ObjectID INT = OBJECT_ID(@sp_name);										-- Retorna a identificação única da procedure atual.
	DECLARE @msgErro NVARCHAR(2048);													-- Declara atributo para logar o erro.

	SET @msgErro = ''
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DA CONEXÃO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SERVIDOR: ' + @@SERVERNAME;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'BANCO DE DADOS: ' + DB_NAME();
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SYSTEM_USER: ' + ISNULL(SYSTEM_USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'USER: ' + ISNULL(USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SPID: ' + ISNULL(CONVERT(nvarchar, @@SPID), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'FUNÇÃO: ' + @sp_name;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DO ERRO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR NUMBER: ' + ISNULL(CONVERT(nvarchar, @ErrorNumber), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR PROCEDURE: ' + @ErrorProcedure;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR LINE: ' + ISNULL(CONVERT(nvarchar, @ErrorLine), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR MESSAGE: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + @ErrorMessage;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'PARÂMETROS:';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + 'Procedure sem parâmetros';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';

	IF(@ErrorNumber != 70000)															
	BEGIN																				
		EXEC xp_logevent 
		 @ErrorNumber		-- Loga um erro no eventviewer com a mensagem informado.
		,@msgErro			-- Loga um erro no eventviewer com a mensagem informado.
		,ERROR;				-- Loga um erro no eventviewer com a mensagem informado.
	END
	ELSE
	BEGIN
		EXEC xp_logevent	-- Loga uma informação no eventviewer com a mensagem informada.
		 @ErrorNumber		-- Loga uma informação no eventviewer com a mensagem informada.
		,@msgErro			-- Loga uma informação no eventviewer com a mensagem informada.
		,WARNING;			-- Loga uma informação no eventviewer com a mensagem informada.
	END;
			
	RAISERROR(					
		 60000				-- Retorna o erro para a chamador.
		,@ErrorMessage		-- Retorna o erro para a chamador.
		,@ErrorState		-- Retorna o erro para a chamador.
		)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscal_Salvar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_NotaFiscal_Salvar]
(
	@ValorTotal decimal(10,2),
	@CodigoCliente INT,
	 @new_identity INT = NULL OUTPUT
)
AS
BEGIN

INSERT INTO [dbo].[NotaFiscal]
           ([ValorTotal]
           ,[CodigoCliente]
           ,[Data])
     VALUES
           (@ValorTotal
           ,@CodigoCliente
           ,GETDATE())
 SET @new_identity = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscalItens_Buscar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_NotaFiscalItens_Buscar]
(
	@Codigo INT
)
AS
BEGIN

SELECT [CodigoNotaFiscalProduto]
      ,[CodigoNota]
      ,[CodigoProduto]	
	  ,p.Nome
	  ,p.Preco
      ,[Quantidade]
  FROM NotaFiscalProduto np
  JOIN Produto p on np.CodigoProduto =p.Codigo
  WHERE np.CodigoNota = @Codigo


END


GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscalProduto_Atualizar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_NotaFiscalProduto_Atualizar]
(
	@CodigoNota INT, 
	@CodigoProduto INT,
	@Quantidade INt,
	@Update bit output
)
AS
BEGIN

UPDATE [dbo].[NotaFiscalProduto]
   SET [CodigoProduto] = @CodigoProduto
      ,[Quantidade] = @Quantidade
 WHERE  CodigoNota = @CodigoNota

IF @@ERROR = 0
    SET @Update = 1
ELSE SET @Update = 0
END
GO
/****** Object:  StoredProcedure [dbo].[usp_NotaFiscalProduto_Salvar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_NotaFiscalProduto_Salvar]
(
	@CodigoNota INT,
	@CodigoProduto INT,
	@Quantidade INT,
	@new_identity INT = NULL OUTPUT
)
AS
BEGIN

INSERT INTO [dbo].[NotaFiscalProduto]
           ([CodigoNota]
           ,[CodigoProduto]
           ,[Quantidade])
     VALUES
           (@CodigoNota
           ,@CodigoProduto
           ,@Quantidade)
SET @new_identity = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Produto_Buscar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Produto_Buscar]
(
	@Codigo INT
)
AS
BEGIN

SELECT  [Codigo]
      ,[Nome]
      ,[Preco]
      ,[CodigoFornecedor]
  FROM [dbo].[Produto]  WHERE Codigo = @Codigo

END

GO
/****** Object:  StoredProcedure [dbo].[usp_Produto_Listar]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =========================================================================================================
-- Author: Paula
-- Description: Retorna uma lista de produtos
-- =========================================================================================================

CREATE PROCEDURE [dbo].[usp_Produto_Listar]
AS
BEGIN TRY
	SET NOCOUNT ON;

SELECT [Codigo]
      ,[Nome]
      ,[Preco]
      ,[CodigoFornecedor]
  FROM [dbo].[Produto]

END TRY

BEGIN CATCH
	DECLARE @ErrorLine INT = ERROR_LINE();												-- Retorna o número da linha onde ocorreu o erro.
	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();								-- Retorna informações sobre a causa do erro.
	DECLARE @ErrorNumber INT = ERROR_NUMBER();											-- Retorna o número de identificação do erro.
	DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();							-- Retorna o nome da procedure ou trigger onde o erro ocorreu.
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();										-- Retorna um indicador numérico com a severidade do erro.
    DECLARE @ErrorState INT = ERROR_STATE();											-- Retorna o estado do erro.
	DECLARE @sp_schema SYSNAME = QUOTENAME(OBJECT_SCHEMA_NAME(@@PROCID));				-- Retorna o schema utilizado na procedure atual.
	DECLARE @sp_name SYSNAME = @sp_schema + '.' + QUOTENAME(OBJECT_NAME(@@PROCID));		-- Retorna o nome  utilizado na procedure atual.
	DECLARE @sp_ObjectID INT = OBJECT_ID(@sp_name);										-- Retorna a identificação única da procedure atual.
	DECLARE @msgErro NVARCHAR(2048);													-- Declara atributo para logar o erro.

	SET @msgErro = ''
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DA CONEXÃO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SERVIDOR: ' + @@SERVERNAME;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'BANCO DE DADOS: ' + DB_NAME();
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SYSTEM_USER: ' + ISNULL(SYSTEM_USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'USER: ' + ISNULL(USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SPID: ' + ISNULL(CONVERT(nvarchar, @@SPID), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'FUNÇÃO: ' + @sp_name;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DO ERRO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR NUMBER: ' + ISNULL(CONVERT(nvarchar, @ErrorNumber), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR PROCEDURE: ' + @ErrorProcedure;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR LINE: ' + ISNULL(CONVERT(nvarchar, @ErrorLine), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR MESSAGE: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + @ErrorMessage;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'PARÂMETROS:';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + 'Procedure sem parâmetros';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';

	IF(@ErrorNumber != 70000)															
	BEGIN																				
		EXEC xp_logevent 
		 @ErrorNumber		-- Loga um erro no eventviewer com a mensagem informado.
		,@msgErro			-- Loga um erro no eventviewer com a mensagem informado.
		,ERROR;				-- Loga um erro no eventviewer com a mensagem informado.
	END
	ELSE
	BEGIN
		EXEC xp_logevent	-- Loga uma informação no eventviewer com a mensagem informada.
		 @ErrorNumber		-- Loga uma informação no eventviewer com a mensagem informada.
		,@msgErro			-- Loga uma informação no eventviewer com a mensagem informada.
		,WARNING;			-- Loga uma informação no eventviewer com a mensagem informada.
	END;
			
	RAISERROR(					
		 60000				-- Retorna o erro para a chamador.
		,@ErrorMessage		-- Retorna o erro para a chamador.
		,@ErrorState		-- Retorna o erro para a chamador.
		)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_Relatorio_TotalVendas]    Script Date: 23/11/2020 08:33:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =========================================================================================================
-- Author: Paula
-- Description: relatorio de total de vendas por produto
-- =========================================================================================================

CREATE PROCEDURE [dbo].[usp_Relatorio_TotalVendas]
AS
BEGIN TRY
	SET NOCOUNT ON;

  SELECT p.Codigo, p.Nome, SUM(Quantidade) as Quantidade, p.Preco
  FROM NotaFiscalProduto np
  join Produto p on np.CodigoProduto = p.Codigo
  GROUP BY  p.Codigo, p.Nome,p.Preco

END TRY

BEGIN CATCH
	DECLARE @ErrorLine INT = ERROR_LINE();												-- Retorna o número da linha onde ocorreu o erro.
	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();								-- Retorna informações sobre a causa do erro.
	DECLARE @ErrorNumber INT = ERROR_NUMBER();											-- Retorna o número de identificação do erro.
	DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();							-- Retorna o nome da procedure ou trigger onde o erro ocorreu.
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();										-- Retorna um indicador numérico com a severidade do erro.
    DECLARE @ErrorState INT = ERROR_STATE();											-- Retorna o estado do erro.
	DECLARE @sp_schema SYSNAME = QUOTENAME(OBJECT_SCHEMA_NAME(@@PROCID));				-- Retorna o schema utilizado na procedure atual.
	DECLARE @sp_name SYSNAME = @sp_schema + '.' + QUOTENAME(OBJECT_NAME(@@PROCID));		-- Retorna o nome  utilizado na procedure atual.
	DECLARE @sp_ObjectID INT = OBJECT_ID(@sp_name);										-- Retorna a identificação única da procedure atual.
	DECLARE @msgErro NVARCHAR(2048);													-- Declara atributo para logar o erro.

	SET @msgErro = ''
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DA CONEXÃO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SERVIDOR: ' + @@SERVERNAME;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'BANCO DE DADOS: ' + DB_NAME();
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SYSTEM_USER: ' + ISNULL(SYSTEM_USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'USER: ' + ISNULL(USER, 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'SPID: ' + ISNULL(CONVERT(nvarchar, @@SPID), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'FUNÇÃO: ' + @sp_name;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'INFORMAÇÕES DO ERRO: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR NUMBER: ' + ISNULL(CONVERT(nvarchar, @ErrorNumber), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR PROCEDURE: ' + @ErrorProcedure;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR LINE: ' + ISNULL(CONVERT(nvarchar, @ErrorLine), 'NULL');
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'ERROR MESSAGE: ';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + @ErrorMessage;
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + 'PARÂMETROS:';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + CHAR(9) + 'Procedure sem parâmetros';
	SET @msgErro = @msgErro + CHAR(13) + CHAR(10) + '-------------------------------------------------------------';

	IF(@ErrorNumber != 70000)															
	BEGIN																				
		EXEC xp_logevent 
		 @ErrorNumber		-- Loga um erro no eventviewer com a mensagem informado.
		,@msgErro			-- Loga um erro no eventviewer com a mensagem informado.
		,ERROR;				-- Loga um erro no eventviewer com a mensagem informado.
	END
	ELSE
	BEGIN
		EXEC xp_logevent	-- Loga uma informação no eventviewer com a mensagem informada.
		 @ErrorNumber		-- Loga uma informação no eventviewer com a mensagem informada.
		,@msgErro			-- Loga uma informação no eventviewer com a mensagem informada.
		,WARNING;			-- Loga uma informação no eventviewer com a mensagem informada.
	END;
			
	RAISERROR(					
		 60000				-- Retorna o erro para a chamador.
		,@ErrorMessage		-- Retorna o erro para a chamador.
		,@ErrorState		-- Retorna o erro para a chamador.
		)
END CATCH
GO
