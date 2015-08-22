package view
{
	import event.EventSolicitud;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.FallaEquipoDTO;
	import model.ProcesoEstatusEnum;
	import model.ProveedorVO;
	import model.SolicitudModel;
	import model.SolicitudVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DateField;
	
	import spark.components.Group;
	
	import utils.NumberFormatUtil;
	
	public class SolicitudViewBase extends Group
	{
		[Inject]
		[Bindable]
		public var solicitudModel:SolicitudModel;
		
		private var solicitudView:SolicitudView = SolicitudView(this);
		private var eventSolicitud:EventSolicitud;
		
		private const CREAR:String = "Crear";
		private const ACTUALIZAR:String = "Actualizar";
		
		[Bindable]protected var flagCreateSolicitud:Boolean = false;
		[Bindable]protected var flagEmpleadoRequisicion:Boolean = true;
		[Bindable]protected var flagEmpleadoAdquisicion:Boolean = false;
		[Bindable]protected var flagProveedor:Boolean = true;
		[Bindable]protected var flagCuentaBancaria:Boolean = true;
		[Bindable]
		protected var acEstatus:ArrayCollection = new ArrayCollection([{estatus:ProcesoEstatusEnum.REQUISICION},{estatus:ProcesoEstatusEnum.ADQUISICION}]);
		
		public function SolicitudViewBase()
		{
			super();
		}
		
		protected function init():void{
			solicitudModel.titleFormulario = CREAR;
		}
		
		/**
		 * Crear una nueva solicitud
		 */
		protected function createSolicitud():void{
			clearFormulario();
			flagCreateSolicitud = true;
			solicitudModel.solicitudSelected = new SolicitudVO();
		}
		
		/**
		 * Label Function para mostrar la marca y el nombre del Artícuo concatenados
		 */
		protected function labelFunctionNombre (item:Object):String{
			return item.nombre + " " + item.paterno + " " + item.materno;
		}
		
		/**
		 * Label Function para mostrar la marca y el nombre del Artícuo concatenados
		 */
		protected function labelFunctionMarcaArticulo (item:Object):String{
			return item.marca + " - " + item.descripcion;
		}
		
		/**
		 * Actualiza los datos de la Adquisición
		 */
		private function updateSolicitudDetalle():void{
			var flagAdd:Boolean = true;
			var articulo:ArticuloVO = null;
			var cantidad:int = 1;
			/*if(solicitudView.autocompleteArticulo.selectedItem != null){
				articulo = solicitudView.autocompleteArticulo.selectedItem as ArticuloVO;
				cantidad = solicitudView.ntsCantidadAdquirida.value;
			}*/
		}
		
		/**
		 * Change Estatus Process
		 * @param event Event Dropdown List
		 */
		protected function changeEstatusProceso(proceso:String):void{
			Alert.show(proceso);
			if(proceso != ""){
				if(proceso == ProcesoEstatusEnum.REQUISICION){
					flagEmpleadoRequisicion = true;
					flagEmpleadoAdquisicion = false;
				}else if(proceso == ProcesoEstatusEnum.ADQUISICION){
					flagEmpleadoAdquisicion = true;
					flagEmpleadoRequisicion = false;
				}else{
					flagEmpleadoAdquisicion = false;
					flagEmpleadoRequisicion = false;
				}
			}
		}
		
		/**
		 * Change DropdownList Forma Pago
		 */
		protected function changeFormaPago():void{
			if(solicitudView.cmbFormaPago.selectedItem != null){
				switch(solicitudView.cmbFormaPago.selectedItem){
					case "Efectivo":
							flagCuentaBancaria = false;
						break;
					case "Transferencia":
							flagCuentaBancaria = true;
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * Evento que se despacha al dar doble clic sobre una Adquisición (Un registro del grid de Adquisición)
		 */
		protected function solicitudSelected(_event:MouseEvent):void{
			if(_event.currentTarget.selectedItem != null){
				flagCreateSolicitud = true;
				solicitudModel.titleFormulario = SolicitudModel.ACTUALIZAR;
				solicitudModel.solicitudSelected = _event.currentTarget.selectedItem;
				
				//Empleado Requisicion
				if(solicitudModel.solicitudSelected.id_empleado_requisicion != null
					&& solicitudModel.solicitudSelected.id_empleado_requisicion != ""){
					for each(var e:EmpleadoVO in solicitudModel.acEmpleadosRequisicion){
						if(e.idEmpleado == solicitudModel.solicitudSelected.id_empleado_requisicion){
							solicitudView.autocompleteEmpleadoRequisicion.selectedItem = e;
							break;
						}
					}
				}
				
				//Empleado Adquisicion
				if(solicitudModel.solicitudSelected.id_empleado_adquisicion != null
						&& solicitudModel.solicitudSelected.id_empleado_adquisicion != ""){
					for each(var ea:EmpleadoVO in solicitudModel.acEmpleadosAdquisicion){
						if(ea.idEmpleado == solicitudModel.solicitudSelected.id_empleado_adquisicion){
							solicitudView.autocompleteEmpleadoAdquisicion.selectedItem = ea;
							break;
						}
					}
					
				}
				
				//Articulo
				if(solicitudModel.solicitudSelected.id_articulo != null 
					&& solicitudModel.solicitudSelected.id_articulo != ""){
					for each(var a:ArticuloVO in solicitudModel.acArticulos){
						if(a.idArticulo == solicitudModel.solicitudSelected.id_articulo){
							solicitudView.autocompleteArticulo.selectedItem = a;
							break;
						}
					}
				}
				
				//Falla
				if(solicitudModel.solicitudSelected.id_falla != null
					&& solicitudModel.solicitudSelected.id_falla != ""){
					for each(var f:FallaEquipoDTO in solicitudModel.acFallasEquipo){
						if(f.id_tfallas == solicitudModel.solicitudSelected.id_falla){
							solicitudView.autocompleteFalla.selectedItem = f;
							break;
						}
					}
				}
				
				//Proveedor
				if(solicitudModel.solicitudSelected.id_prooveedor != null
						&& solicitudModel.solicitudSelected.id_prooveedor != ""){
					for each(var p:ProveedorVO in solicitudModel.acProveedor){
						if(solicitudModel.solicitudSelected.id_prooveedor == p.idProveedor){
							solicitudView.autocompleteProveedor.selectedItem = p;
							break;
						}
					}
				}
				
				solicitudView.txtNomSolicitud.text = solicitudModel.solicitudSelected.nombre_solicitud;
				solicitudView.txtCantidad.text = solicitudModel.solicitudSelected.cantidad;
				//Costo
				solicitudView.txtCosto.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudModel.solicitudSelected.costo_unidad));
				//Total
				solicitudView.lblTotal.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudModel.solicitudSelected.costo_total));
				
				if(solicitudModel.solicitudSelected.forma_pago != ""){
					switch(solicitudModel.solicitudSelected.forma_pago){
						case "Efectivo":
								flagCuentaBancaria = false;
							break;
						case "Transferencia":
								flagCuentaBancaria = true;
							break;
						default:
							break;
					}
					solicitudView.cmbFormaPago.selectedItem = solicitudModel.solicitudSelected.forma_pago;
					
				}
				solicitudView.txtTiempoEntrega.text = solicitudModel.solicitudSelected.tiempo_entrega;
				solicitudView.txtObservaciones.text = solicitudModel.solicitudSelected.observaciones;
				if(solicitudModel.solicitudSelected.fecha_requisicion != ""){
					solicitudView.fechaRequisicion.selectedDate = DateField.stringToDate(solicitudModel.solicitudSelected.fecha_requisicion, "YYYY/MM/DD");
				}
				if(solicitudModel.solicitudSelected.fecha_adquisicion != ""){
					solicitudView.fechaAdquisicion.selectedDate = DateField.stringToDate(solicitudModel.solicitudSelected.fecha_adquisicion, "YYYY/MM/DD");
				}
				
			}
		}
		
		/**
		 * Remove the character from NumberFormatt
		 */
		public function removeCharacter(value:String):String{
			var temp:String = solicitudView.txtCosto.text;
			if(temp != ""){
				var _indexA:Number = temp.search(",");
				var _indexB:Number = temp.search("$");
				
				while(_indexA > -1){
					temp = temp.replace(",","");
					_indexA = temp.search(",");
				}
				
				while(_indexB > -1){
					temp = temp.replace("$", "");
					_indexB = temp.search("$");
				}
			}
			 return temp;
		}
		
		/**
		 * Calcula los valores del costo y total de acuerdo a la cantidad ingresada y el costo por unidad
		 */
		public function calCosto():void{
			if(solicitudView.txtCosto.text != ""){
				//removeCharacter();
				solicitudView.txtCosto.text = removeCharacter(solicitudView.txtCosto.text);
				if(solicitudView.txtCantidad.text != ""){
					solicitudView.lblTotal.text = "$ " + NumberFormatUtil.formatThousandsNumber(Number(solicitudView.txtCantidad.text) * Number(solicitudView.txtCosto.text), 3);
				}
				solicitudView.txtCosto.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudView.txtCosto.text), 3);
			}
		}
		
		/**
		 * Limpia el Formulario de la Adquisición Detalle
		 */
		public function clearFormulario():void{
			solicitudModel.titleFormulario = CREAR;
			flagCreateSolicitud = false;
			solicitudView.txtNomSolicitud.text = "";
			solicitudView.txtCantidad.text = "";
			solicitudView.txtObservaciones.text = "";
			solicitudView.autocompleteEmpleadoRequisicion.removeAll();
			solicitudView.autocompleteArticulo.removeAll();
			solicitudView.autocompleteFalla.removeAll();
		}
		
		public function saveSolicitud():void{
			switch(solicitudModel.titleFormulario){
				case SolicitudModel.CREAR:
						saveUpdate();
						eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_SAVE_SOLICITUD);
						dispatchEvent(eventSolicitud);
						clearFormulario();
					break;
				case SolicitudModel.ACTUALIZAR:
						saveUpdate();
						eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_UPDATE);
						dispatchEvent(eventSolicitud);
						clearFormulario();
					break;
				default:
					break;
			}
		}
		
		/**
		 * Obtiene los datos del articulo de la pantalla y los setea a nuestro itemSelected
		 */
		public function saveUpdate():void{
			if(solicitudModel.solicitudSelected.id_solicitud == null || solicitudModel.solicitudSelected.id_solicitud == ""){
				solicitudModel.solicitudSelected = new SolicitudVO();
			}
			if(solicitudView.autocompleteEmpleadoRequisicion.selectedItem != null){
				solicitudModel.solicitudSelected.id_empleado_requisicion = EmpleadoVO(solicitudView.autocompleteEmpleadoRequisicion.selectedItem).idEmpleado;
			}
			if(solicitudView.autocompleteArticulo.selectedItem != null){
				solicitudModel.solicitudSelected.id_articulo = ArticuloVO(solicitudView.autocompleteArticulo.selectedItem).idArticulo;
			}
			solicitudModel.solicitudSelected.cantidad = solicitudView.txtCantidad.text;
			if(solicitudView.autocompleteFalla.selectedItem != null){
				solicitudModel.solicitudSelected.id_falla = FallaEquipoDTO(solicitudView.autocompleteFalla.selectedItem).id_tfallas; 
			}
			if(solicitudView.fechaRequisicion.selectedDate != null
				&& solicitudView.fechaRequisicion.enabled){
				var dateSolicitud:Date = solicitudView.fechaRequisicion.selectedDate;
				if(dateSolicitud == null){
					solicitudView.fechaRequisicion.errorString = "Debes ingresar la fecha de adquisición."
				}else{
					solicitudModel.solicitudSelected.fecha_requisicion = dateSolicitud.getFullYear().toString() +	'/' + (dateSolicitud.getMonth()+1).toString() + '/' + dateSolicitud.getDate();
					solicitudView.fechaRequisicion.errorString = "";
				}
			}
			solicitudModel.solicitudSelected.nombre_solicitud 	= solicitudView.txtNomSolicitud.text;
			solicitudModel.solicitudSelected.observaciones 		= solicitudView.txtObservaciones.text;
			solicitudModel.solicitudSelected.estatus_proceso 	= ProcesoEstatusEnum.REQUISICION;
		}
		
		
		/**
		 * Elimina la Adquisición
		 */
		public function deleteSolicitud():void{
			if(solicitudModel.solicitudSelected != null){
				eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_DELETE_SOLICITUD);
				dispatchEvent(eventSolicitud);
				flagCreateSolicitud = false;
				clearFormulario();
			}
		}
		
		public function findArticulos():void{
			var articulo:ArticuloVO = new ArticuloVO();
			eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_FIND_ARTICULOS);
			eventSolicitud.articuloVO = articulo;
			dispatchEvent(eventSolicitud);
		}
	}
}