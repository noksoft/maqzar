package event
{
	import flash.events.Event;
	
	import model.ArticuloVO;
	import model.CategoriaVO;
	import model.EmpleadoVO;
	import model.MarcaVO;
	import model.RequisicionVO;
	import model.SubMarcaVO;
	
	public class RequisicionEvent extends Event
	{
		public static const EVENT_SAVE_REQUISICION:String = "eventSaveRequisicion";
		public static const EVENT_UPDATE_REQUISICION:String = "eventUpdateRequisicion";
		public static const EVENT_DELETE_REQUISICION:String = "eventDeleteRequisicion";
		public static const EVENT_FIND_REQUISICIONES:String = "eventFindRequisiciones";
		
		public static const EVENT_FIND_ARTICULOS:String = "eventFindArticulos";
		public static const EVENT_FIND_CATEGORIAS:String = "eventFindCategorias";
		public static const EVENT_FIND_EMPLEADOS:String = "eventFindEmpleados";
		public static const EVENT_FIND_MARCAS:String = "eventFindMarcas";
		public static const EVENT_FIND_SUBMARCA:String = "eventFindSubmarca";
		
		public static const EVENT_SAVE_SUCCEFULL:String = "eventSaveSuccefull";
		
		public var requisicionVO:RequisicionVO;
		public var articuloVO:ArticuloVO;
		public var categoriaVO:CategoriaVO;
		public var empleadoVO:EmpleadoVO;
		public var marcaVO:MarcaVO;
		public var submarca:SubMarcaVO;
		
		public function RequisicionEvent(type:String)
		{
			super(type, true, true);
		}
	}
}