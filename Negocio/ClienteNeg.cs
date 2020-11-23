using Modelo;
using Repositorio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ClienteNeg
    {
        public static List<Cliente> Listar()
        {
            try
            {
                return ClienteRep.Listar();
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
                return ClienteRep.Buscar(codigo);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
