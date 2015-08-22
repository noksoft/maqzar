package service
{
	import constants.NOKConstants;
	
	import model.ArticuloVO;
	import model.CategoriaVO;
	import model.EmpleadoVO;
	import model.FallaVO;
	import model.MarcaVO;
	import model.RequisicionVO;
	import model.SubCategoriaVO;
	import model.SubMarcaVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class RequisicionService
	{
		private var requisicionRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_REQUISICIONES);
		private var articulosRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_ARTICULOS);
		private var categoriasRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_CATEGORIAS);
		private var empleadosRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_EMPLEADOS);
		private var fallaRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_FALLA);
		
		public function RequisicionService()
		{
			requisicionRemote.endpoint = NOKConstants.SERVICE_URL;
			requisicionRemote.showBusyCursor = true;
			
			articulosRemote.endpoint = NOKConstants.SERVICE_URL;
			articulosRemote.showBusyCursor = true;
			
			categoriasRemote.endpoint = NOKConstants.SERVICE_URL;
			categoriasRemote.showBusyCursor = true;
			
			empleadosRemote.endpoint = NOKConstants.SERVICE_URL;
			empleadosRemote.showBusyCursor = true;
			
			fallaRemote.endpoint = NOKConstants.SERVICE_URL;
			fallaRemote.showBusyCursor = true;
		}
		
		/********************	REQUISICIONES	*************************/
		public function findAll(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.infoRequisicion(vo);
		}
		public function save(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.insertRequisicion(vo);
		}
		public function update(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.updateRequisicion(vo);
		}
		public function deleteRequisicion(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.deleteRequisicion(vo);
		}
		
		/*******************	FALLA			**************************/
		public function getFallas(vo:FallaVO):AsyncToken{
			return fallaRemote.catFalla(vo);
		}
		
		/*******************	ARTICULOS		**************************/
		public function getArticulos(vo:ArticuloVO):AsyncToken{
			return articulosRemote.getArticulosByTipocategoria(vo);
		}
		
		/******************		CATEGORIA		*************************/
		public function getCategorias(vo:CategoriaVO):AsyncToken{
			return categoriasRemote.catCategoria(vo);
		}
		
		/******************		SUBCATEGORIA	************************/
		public function getSubcategorias(vo:SubCategoriaVO):AsyncToken{
			return categoriasRemote.catSubcategoria(vo);
		}
		
		/******************		MARCAS			************************/
		public function getMarcas(vo:MarcaVO):AsyncToken{
			return articulosRemote.catMarca(vo);
		}
		
		/*****************		SUBMARCA		*************************/
		public function getSubmarcas(vo:SubMarcaVO):AsyncToken{
			return articulosRemote.catSubmarca(vo);
		}
		
		/*****************		EMPLEADOS		************************/
		public function getEmpleados(vo:EmpleadoVO):AsyncToken{
			return empleadosRemote.infoEmpleado(vo);
		}
		
	}
}