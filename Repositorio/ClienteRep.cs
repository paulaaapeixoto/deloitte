using Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Repositorio
{
    public class ClienteRep
    {
        public static List<Cliente> Listar()
        {
            try
            {
                List<Cliente> lista = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_Cliente_Listar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        lista = new List<Cliente>();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    Cliente cliente = new Cliente();
                                    cliente.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    cliente.Nome = reader.GetString(reader.GetOrdinal("Nome"));
                                    cliente.Documento = reader.GetString(reader.GetOrdinal("Documento"));
                                    lista.Add(cliente);
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

        public static Cliente Buscar(int codigo)
        {

            try
            {
                Cliente cliente = null;
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.BancoDados))
                {

                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[dbo].[usp_Cliente_Buscar]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Codigo", codigo);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    cliente = new Cliente();
                                    cliente.Codigo = reader.GetInt32(reader.GetOrdinal("Codigo"));
                                    cliente.Nome = reader.GetString(reader.GetOrdinal("Nome"));
                                    cliente.Documento = reader.GetString(reader.GetOrdinal("Documento"));
                                }
                            }
                        }
                    }

                }
                return cliente;
            }
            catch (Exception)
            {
                throw;
            }


        }
    }
}
