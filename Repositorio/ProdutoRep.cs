using Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Repositorio
{
    public class ProdutoRep
    {
        public static List<Produto> Listar()
        {
            try
            {
                List<Produto> lista = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_Produto_Listar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        lista = new List<Produto>();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    Produto produto = new Produto();
                                    produto.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    produto.Nome = reader.GetString(reader.GetOrdinal("Nome"));
                                    produto.Preco = reader.GetDecimal(reader.GetOrdinal("Preco"));
                                    produto.Fornecedor = new Fornecedor();
                                    produto.Fornecedor.Codigo = reader.GetInt32(reader.GetOrdinal("CodigoFornecedor"));
                                    lista.Add(produto);
                                }
                            }
                        }
                    }
                }
                return lista;
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static Produto Buscar(int codigo)
        {

            try
            {
                Produto produto = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_Produto_Buscar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Codigo", codigo);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    produto = new Produto();
                                    produto.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    produto.Nome = reader.GetString(reader.GetOrdinal("Nome"));
                                    produto.Preco = reader.GetDecimal(reader.GetOrdinal("Preco"));
                                }
                            }
                        }
                    }

                }
                return produto;
            }
            catch (Exception)
            {
                throw;
            }


        }



    }
}
