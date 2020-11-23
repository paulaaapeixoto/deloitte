using Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorio
{
    public class NotaFiscalRep
    {
        public static List<NotaFiscal> Listar()
        {
            try
            {
                List<NotaFiscal> lista = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscal_Listar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        lista = new List<NotaFiscal>();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    NotaFiscal nota = new NotaFiscal();
                                    nota.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    nota.ValorTotal = reader.GetDecimal(reader.GetOrdinal("ValorTotal"));
                                    nota.Cliente = new Cliente();
                                    nota.Cliente.Codigo = reader.GetInt32(reader.GetOrdinal("CodigoCliente"));
                                    nota.Data = reader.GetDateTime(reader.GetOrdinal("Data"));
                                    lista.Add(nota);
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

        public static bool Excluir(int codigo)
        {

            try
            {
                bool excluido = false;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscal_Excluir]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@CodigoNota", codigo);
                    command.Parameters.Add("@Deleted", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    connection.Open();
                    command.ExecuteReader();


                    excluido = Convert.ToBoolean(command.Parameters["@Deleted"].Value);

                    if (!excluido)
                    {
                        throw new Exception("Ocorreu um erro ao excluir a nota, tente novamente!");
                    }

                }
                return excluido;
            }
            catch (Exception)
            {
                throw;
            }


        }

        public static int Incluir(NotaFiscal nota)
        {

            try
            {
                int incluido = 0;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscal_Salvar]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ValorTotal", nota.ValorTotal);
                    command.Parameters.AddWithValue("@CodigoCliente", nota.Cliente.Codigo);
                    command.Parameters.Add("@new_identity", SqlDbType.Int).Direction = ParameterDirection.Output;

                    connection.Open();
                    command.ExecuteReader();


                    incluido = Convert.ToInt32(command.Parameters["@new_identity"].Value);

                }
                return incluido;
            }
            catch (Exception)
            {
                throw;
            }


        }


        public static bool Atualizar(NotaFiscal nota)
        {

            try
            {
                bool atualizado = false;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscal_Atualizar]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Codigo", nota.Codigo);
                    command.Parameters.AddWithValue("@ValorTotal", nota.ValorTotal);
                    command.Parameters.AddWithValue("@CodigoCliente", nota.Cliente.Codigo);
                    command.Parameters.Add("@Update", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    connection.Open();
                    command.ExecuteReader();

                    atualizado = Convert.ToBoolean(command.Parameters["@Update"].Value);
                }

                return true;

            }
            catch (Exception)
            {
                throw;
            }


        }


        public static int IncluirItens(int codigoNota, Item item)
        {

            try
            {
                int incluido = 0;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscalProduto_Salvar]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@CodigoNota", codigoNota);
                    command.Parameters.AddWithValue("@CodigoProduto", item.Produto.Codigo);
                    command.Parameters.AddWithValue("@Quantidade", item.Quantidade);
                    command.Parameters.Add("@new_identity", SqlDbType.Int).Direction = ParameterDirection.Output;

                    connection.Open();
                    command.ExecuteReader();


                    incluido = Convert.ToInt32(command.Parameters["@new_identity"].Value);

                }
                return incluido;
            }
            catch (Exception)
            {
                throw;
            }


        }


        public static bool AtualizarItens(int codigoNota, Item item)
        {

            try
            {
                bool atualizado = false;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscalProduto_Atualizar]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@CodigoNota", codigoNota);
                    command.Parameters.AddWithValue("@CodigoProduto", item.Produto.Codigo);
                    command.Parameters.AddWithValue("@Quantidade", item.Quantidade);
                    command.Parameters.Add("@Update", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    connection.Open();
                    command.ExecuteReader();

                    atualizado = Convert.ToBoolean(command.Parameters["@Update"].Value);

                }
                return atualizado;
            }
            catch (Exception)
            {
                throw;
            }


        }
        public static NotaFiscal Buscar(int codigo)
        {

            try
            {
                NotaFiscal nota = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscal_Buscar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Codigo", codigo);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    nota = new NotaFiscal();
                                    nota.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    nota.ValorTotal = reader.GetDecimal(reader.GetOrdinal("ValorTotal"));
                                    nota.Cliente = new Cliente();
                                    nota.Cliente.Codigo = reader.GetInt32(reader.GetOrdinal("CodigoCliente"));
                                    nota.Data = reader.GetDateTime(reader.GetOrdinal("Data"));
                                }
                            }
                        }
                    }

                }
                return nota;
            }
            catch (Exception)
            {
                throw;
            }


        }

        public static List<Item> BuscarItens(int codigo)
        {

            try
            {
                List<Item> lista = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_NotaFiscalItens_Buscar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Codigo", codigo);
                        lista = new List<Item>();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    Item item = new Item();
                                    item.Produto = new Produto();
                                    item.Produto.Codigo = reader.GetInt32(reader.GetOrdinal("CodigoProduto"));
                                    item.Produto.Nome = reader.GetString(reader.GetOrdinal("Nome"));
                                    item.Produto.Preco = reader.GetDecimal(reader.GetOrdinal("Preco"));
                                    item.Quantidade = reader.GetInt32(reader.GetOrdinal("Quantidade"));
                                    lista.Add(item);
                                }
                            }
                        }
                    }

                }
                return lista;
            }
            catch (Exception)
            {
                throw;
            }


        }

        public static List<Item> RelatorioTotalVendas()
        {
            try
            {
                List<Item> lista = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_Relatorio_TotalVendas]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        lista = new List<Item>();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    Item nota = new Item();
                                    nota.Quantidade = reader.GetInt32(reader.GetOrdinal("Quantidade"));
                                    nota.Produto = new Produto();
                                    nota.Produto.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    nota.Produto.Nome = reader.GetString(reader.GetOrdinal("Nome"));
                                    nota.Produto.Preco = reader.GetDecimal(reader.GetOrdinal("Preco"));
                                    lista.Add(nota);
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

    }
}
