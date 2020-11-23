using Modelo;
using Repositorio;
using System;
using System.Collections.Generic;

namespace Negocio
{
    public class ProdutoNeg
    {
        public static List<Produto> Listar()
        {
            try
            {
                return ProdutoRep.Listar();
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
                return ProdutoRep.Buscar(codigo);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
