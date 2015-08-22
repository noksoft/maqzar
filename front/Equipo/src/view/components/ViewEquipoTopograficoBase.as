package view.components
{
	import event.CommonEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import model.EquipoVO;
	import model.MarcaMotorVO;
	import model.MarcaVO;
	import model.SubCategoriaVO;
	import model.SubMarcaVO;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.DateField;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import utils.AlertUtils;
	
	import view.AlertConfirmation;
	
	public class ViewEquipoTopograficoBase extends VBox
	{
		/***********	VARIABLE'S	*****************/
		[Bindable]public var titlePanel:String = "Equipo Topografico";
		[Bindable]protected var titleFormulario:String;
		private const CREAR:String = "Crear";
		private const ACTUALIZAR:String = "Actualizar";
		
		protected var fileReferenceFoto:FileReference;
		
		[Bindable]public var listEquipos:ArrayCollection = new ArrayCollection();
		[Bindable]public var acTipoMedidas:ArrayCollection = new ArrayCollection([{name:'Horas'}, {name:'Kilometros'}, {name:'metros'}]);
		[Bindable]public var acListSubcategorias:ArrayCollection;
		[Bindable]public var acListMarcas:ArrayCollection;
		[Bindable]public var acListSubmarcas:ArrayCollection;
		[Bindable]protected var maxYear:int;
		
		private var roEquipoData:RemoteObject = new RemoteObject();
		private var roMarcaSubmarca:RemoteObject = new RemoteObject();
		private var roCategoriaData:RemoteObject = new RemoteObject();
		
		[Bindable]protected var flagMarca:Boolean = false;
		[Bindable]protected var flagSubmarca:Boolean = false;
		
		[Bindable]
		public var itemSelected:EquipoVO = new EquipoVO();
		
		public var viewEquipo:ViewEquipoTopografico = ViewEquipoTopografico(this);
		
		public function preInit():void{
			titleFormulario = CREAR;
			maxYear = new Date().fullYear + 1;
			
			//equipoBusiness
			titleFormulario = CREAR;
			//Initialization to Remote Object
			//EQUIPO
			roEquipoData.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roEquipoData.destination = "equipoBusiness";
			roEquipoData.showBusyCursor = true;
			
			
			//EQUIPO
			roEquipoData.getOperation("infoEquipo").addEventListener(ResultEvent.RESULT, resultCatItems);
			roEquipoData.getOperation("infoEquipo").addEventListener(FaultEvent.FAULT, faultCatItems);
			
			//INSERT EQUIPO
			roEquipoData.getOperation("insertEquipo").addEventListener(ResultEvent.RESULT, insertItemHandler);
			roEquipoData.getOperation("insertEquipo").addEventListener(FaultEvent.FAULT, insertItemFault);
			
			//UPDATE EQUIPO
			roEquipoData.getOperation("updateEquipo").addEventListener(ResultEvent.RESULT, updateItemHandler);
			roEquipoData.getOperation("updateEquipo").addEventListener(FaultEvent.FAULT, updateItemFault);
			
			//DELETE EQUIPO
			roEquipoData.getOperation("deleteEquipo").addEventListener(ResultEvent.RESULT, deleteItemHandler);
			roEquipoData.getOperation("deleteEquipo").addEventListener(FaultEvent.FAULT, deleteItemFault);
			
			//MARCA / SUBMARCA
			roMarcaSubmarca.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roMarcaSubmarca.destination = "articuloBusiness";
			roMarcaSubmarca.showBusyCursor = true;
			
			//CATEGORIA
			roCategoriaData.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roCategoriaData.destination = "categoriaBusiness";
			roCategoriaData.showBusyCursor = true;
			
			//Imagenes
			fileReferenceFoto = new FileReference();
			fileReferenceFoto.addEventListener(Event.SELECT, fotoSeleccionada);

			//SubCategoria
			roCategoriaData.getOperation("catSubcategoria").addEventListener(ResultEvent.RESULT, resultCatSubCategoria);
			roCategoriaData.getOperation("catSubcategoria").addEventListener(FaultEvent.FAULT, faultCatSubCategoria);
			
			//MARCA
			//Marca
			roMarcaSubmarca.getOperation("catMarca").addEventListener(ResultEvent.RESULT, resultCatMarca);
			roMarcaSubmarca.getOperation("catMarca").addEventListener(FaultEvent.FAULT, faultCatMarca);
			
			//SubMarca
			roMarcaSubmarca.getOperation("catSubmarca").addEventListener(ResultEvent.RESULT, resultSubMarca);
			roMarcaSubmarca.getOperation("catSubmarca").addEventListener(FaultEvent.FAULT, faultSubMarca);
			
			var subCategoriaTemp:SubCategoriaVO = new SubCategoriaVO();
			subCategoriaTemp.idCategoria = "5";
			roCategoriaData.catSubcategoria(subCategoriaTemp);
			
		}
		
		public function init():void{
			updateData();
			
			//Imagenes
			fileReferenceFoto = new FileReference();
			fileReferenceFoto.addEventListener(Event.SELECT, fotoSeleccionada);
		}
		
		protected function selectedItem(_event:Event):void{
			titleFormulario = ACTUALIZAR;
			viewEquipo.vsEquipo.selectedIndex = 1;
			itemSelected = _event.currentTarget.selectedItem;
			
			viewEquipo.dtf_adquisicion.selectedDate = DateField.stringToDate(itemSelected.fechaadquisicion, "YYYY/MM/DD");
			
			for each(var _subCategoria:SubCategoriaVO in acListSubcategorias){
				if(_subCategoria.idSubcategoria == itemSelected.id_subcategoria){
					viewEquipo.listSubCategoria.selectedItem = _subCategoria;
					changeSubcategoria();
					break;
				}
			}
			
			switch(itemSelected.tipoadquisicion){
				case 'N':
					viewEquipo.radioTipoAdquision.selectedValue = "Nuevo";
					break;
				case 'U':
					viewEquipo.radioTipoAdquision.selectedValue = "Usado";
					break;
			}
			
			viewEquipo.nsModelo.value = Number(itemSelected.anioadquisicion);
			
			viewEquipo.txtFactura.enabled = false;
			viewEquipo.txtNoSerie.enabled = false;
		}
		
		public function updateData():void
		{
			itemSelected = new EquipoVO();
			itemSelected.id_categoria = '5';
			if(viewEquipo.txtNumeroEconomico != null && viewEquipo.txtNumeroEconomico.text != ""){
				itemSelected = new EquipoVO();
				itemSelected.numeroeconomico = viewEquipo.txtNumeroEconomico.text;
			}
			roEquipoData.infoEquipo(itemSelected);
		}
		
		/**
		 * Limpia los filtros
		 */
		protected function cleanFilters():void{
			//	viewEquipo.txtNumeroEconomico.text = "";
			updateData();
		}
		
		/**
		 * Función que se ejecuta al seleccionar un archivo (imagen a guardar)
		 */
		private function fotoSeleccionada(event:Event):void {
			fileReferenceFoto.load();
			viewEquipo.txtImageFoto.text = fileReferenceFoto.name;
			//viewMaquinariaPesada.imgFoto.source = fileReferenceFoto.data;
			//viewMaquinariaPesada.imgFoto.fillMode = BitmapFillMode.SCALE;
		}
		
		/**
		 * Funciòn que permite obtener la imagen del Equipo y guardarla
		 */
		protected function obtenerFoto():void
		{
			var arr:Array = [];
			arr.push(new FileFilter("Imagenes", ".gif;*.jpeg;*.jpg;*.png"));
			fileReferenceFoto.browse(arr);
		}
		
		
		protected function changeTipoAdquisicion():void{
			var value:String = viewEquipo.radioTipoAdquision.selection.label;
			if(value != ""){
				switch(value){
					case "Nuevo":
						itemSelected.tipoadquisicion = "N";
						break;
					case "Usado":
						itemSelected.tipoadquisicion = "U";
						break;
					default:
						itemSelected.tipoadquisicion = "";
						break;
				}
			}else{
				itemSelected.tipoadquisicion = "";
			}
		}
		
		/**
		 * Selección de una subcategoria
		 */
		protected function changeSubcategoria():void{
			if(viewEquipo.listSubCategoria.selectedItem != null){
				var marcaTemp:MarcaVO = new MarcaVO();
				marcaTemp.idSubcategoria = SubCategoriaVO(viewEquipo.listSubCategoria.selectedItem).idSubcategoria;
				roMarcaSubmarca.catMarca(marcaTemp);
				flagMarca = true;
				acListSubmarcas = new ArrayCollection();
				flagSubmarca = false;
			}
		}
		
		/**
		 * Selección de una Marca
		 */
		protected function changeMarca():void{
			if(viewEquipo.listMarca.selectedItem != null){
				var submarcaTemp:SubMarcaVO = new SubMarcaVO();
				submarcaTemp.idMarca = MarcaVO(viewEquipo.listMarca.selectedItem).idMarca;
				roMarcaSubmarca.catSubmarca(submarcaTemp);
				flagSubmarca = true;
			}
		}
		
		private function cargarPropiedadesImagenes():void{
			try{
				//Foto
				if(fileReferenceFoto != null && fileReferenceFoto.data.length > 0){
					itemSelected.fotoequipo = viewEquipo.txtImageFoto.text;
					itemSelected.contentFoto = fileReferenceFoto.data;
				}
				
			}catch(e:Error){
				trace(e.message);
			}				
		}
		
		public function saveItem():void
		{
			//var arrayValidationResult:Array = Validator.validateAll([validateSubCategoria, validateSubMarca, validateNombre, validateNoParte, validateStockMin, validateStockMax, validateUbicacion, validateFechaAdquisicion]);
			switch(titleFormulario){
				case CREAR:
					//if(arrayValidationResult.length == 0){
					saveUpdate();
					//roEquipoData.insertArticulo(itemSelected);
					roEquipoData.insertEquipo(itemSelected);
					
					//}else{
					//	AlertUtils.showNoticeMessage("Notificación", "Debe de seleccionar los campos obligatorios");
					//}
					break;
				case ACTUALIZAR:
					//if(arrayValidationResult.length == 0){
					saveUpdate();
					roEquipoData.updateEquipo(itemSelected);
					//roEquipoData.updateArticulo(itemSelected);
					//}else{
					//	AlertUtils.showNoticeMessage("Notificación", "Debe de seleccionar los campos obligatorios");
					//}
					break;
				default:
					break;
			}
		}
		
		/**
		 * Obtiene los datos del equipo de la pantalla y los setea a nuestro itemSelected(Equipo seleccionado)
		 */
		public function saveUpdate():void
		{
			cargarPropiedadesImagenes();
			//No Economico
			itemSelected.numeroeconomico = viewEquipo.txtNoEconomico.text;			
			//No serie
			itemSelected.numeroserie = viewEquipo.txtNoSerie.text;
			//Factura
			itemSelected.factura = viewEquipo.txtFactura.text;
			//idEquipo
			itemSelected.id_equipo = itemSelected.numeroserie + itemSelected.factura;
			//Carga Foto
			//Subcategoria
			itemSelected.id_subcategoria = SubCategoriaVO(viewEquipo.listSubCategoria.selectedItem).idSubcategoria;
			//Marca
			itemSelected.id_marca = MarcaVO(viewEquipo.listMarca.selectedItem).idMarca;
			//Submarca
			itemSelected.id_submarca =  SubMarcaVO(viewEquipo.listSubMarca.selectedItem).idSubmarca;
			//Fecha adquisicion
			var tempDate:Date = viewEquipo.dtf_adquisicion.selectedDate;
			if(tempDate == null){
				//view.dtf_adquisicion.text = "Fecha:__ ___ ___";
				viewEquipo.dtf_adquisicion.errorString = "Debes ingresar la fecha de adquisición."
			}else{
				itemSelected.fechaadquisicion = tempDate.getFullYear().toString() +	'/' + (tempDate.getMonth()+1).toString() + '/' + tempDate.getDate();
				viewEquipo.dtf_adquisicion.errorString = "";
			}
			//Tipo Adquisicion
			var valueTipoAdquisicion:String = viewEquipo.radioTipoAdquision.selection.label;
			if(valueTipoAdquisicion != ""){
				switch(valueTipoAdquisicion){
					case "Nuevo":
						itemSelected.tipoadquisicion = "N";
						break;
					case "Usado":
						itemSelected.tipoadquisicion = "U";
						break;
					default:
						itemSelected.tipoadquisicion = "";
						break;
				}
			}else{
				itemSelected.tipoadquisicion = "";
			}
			
			//Año Adquisicion
			itemSelected.anioadquisicion = viewEquipo.dtf_adquisicion.selectedDate.fullYear.toString();
			//Modelo
			var tempValue:Number = viewEquipo.nsModelo.value;
			if(tempValue > 1960){
				itemSelected.anioequipo= tempValue.toString();
				viewEquipo.nsModelo.errorString = "";
			}else{
				viewEquipo.nsModelo.errorString = "la fecha debe de ser mayor a 1960.";
			}
			//Descripciòn
			itemSelected.descripcion = viewEquipo.txtDescripcion.text;
			//Cambio Aceite
			itemSelected.cambioaceite = viewEquipo.nsCambAceite.value.toString();
			
		}
		
		public function deleteItem():void
		{
			if(itemSelected != null && itemSelected.id_equipo != null && itemSelected.id_equipo != ""){
				var customAlertConfirmation:AlertConfirmation = new AlertConfirmation();
				customAlertConfirmation.newCustomAlert("Por favor confirma!", "¿Estás seguro de Eliminar el Equipo?", 340, 155);
				customAlertConfirmation.addEventListener(CommonEvent.CUSTOM_ALERT_ACCEPTED_EVENT, listenerAcceptedConfirmation);
				PopUpManager.addPopUp(customAlertConfirmation, DisplayObject(FlexGlobals.topLevelApplication),true);
			}
		}
		
		public function listenerAcceptedConfirmation(_event:CommonEvent):void
		{
			if(itemSelected != null && itemSelected.id_equipo != null && itemSelected.id_equipo != ""){
				roEquipoData.deleteEquipo(itemSelected);
			}
		}
		
		public function cleanFormulario():void
		{
			titleFormulario = CREAR;
			itemSelected = new EquipoVO();
			
			//No. Economico
			viewEquipo.txtNoEconomico.text = "";
			//No. Serie
			viewEquipo.txtNoSerie.text = "";
			viewEquipo.txtNoSerie.enabled = true;
			//Factura
			viewEquipo.txtFactura.text = "";
			viewEquipo.txtFactura.enabled = true;
			//Foto
			viewEquipo.txtImageFoto.text = "";
			fileReferenceFoto.cancel();
			
			//Subcategoria
			viewEquipo.listSubCategoria.selectedItem = null;
			//Marca
			viewEquipo.listMarca.selectedItem = null;
			//Submarca
			viewEquipo.listSubMarca.selectedItem = null;
			
			//Fecha Adquisición
			viewEquipo.dtf_adquisicion.selectedDate = new Date();
			
			//Tipo adquisición
			viewEquipo.radioTipoAdquision.selectedValue = "Nuevo";
			//Modelo
			viewEquipo.nsModelo.value = maxYear - 1;
			//Descripción
			viewEquipo.txtDescripcion.text = "";
			//Cambio de aceite
			viewEquipo.nsCambAceite.value = 500;
			
			acListMarcas = new ArrayCollection();
			acListSubmarcas = new ArrayCollection();
			
		}
		
		
		
		/***************************************************************************************************************************************/
		/******************************************	REMOTE OBJECTS	****************************************************************************/
		public function resultCatItems(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					listEquipos = _event.result as ArrayCollection;
					viewEquipo.vsEquipo.selectedIndex = 0;
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de los Equipos");
			}
		}
		
		public function faultCatItems(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudieron cargar los Equipos.");
		}
		
		public function insertItemHandler(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					itemSelected = new EquipoVO();
					if(listEquipos != null){
						listEquipos.addItem(EquipoVO(_event.result));
						viewEquipo.vsEquipo.selectedIndex = 0;
						cleanFormulario();
						updateData();
					}
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo guardar la información del Equipo");
			}
		}
		
		public function insertItemFault(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudo guardar el Equipo.");
		}
		
		public function updateItemHandler(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					itemSelected = new EquipoVO();
					updateData();
					cleanFormulario();
				}
			}catch(e:Error){
				//Alert.show("Error", "updateCliente" + e.message);
				AlertUtils.showErrorMessage("Error", "No se pudo actualizar la información del Equipo");
			}
		}
		
		public function updateItemFault(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudo actualizar el Equipo.");
		}
		
		public function deleteItemHandler(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					itemSelected = null;
					cleanFormulario();
					updateData();
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo borrar el Equipo");
			}
		}
		
		public function deleteItemFault(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudo borrar el Equipo.");
		}
		//subCategoria
		public function resultCatSubCategoria (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					acListSubcategorias = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubCategorías");
			}
		}
		public function faultCatSubCategoria (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las SubCategorías.");
		}
		
		//catMarca
		public function resultCatMarca (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					acListMarcas = _event.result as ArrayCollection;
					if(itemSelected != null && itemSelected.id_equipo != null && itemSelected.id_equipo != ""){
						for each(var _marca:MarcaVO in acListMarcas){
							if(_marca.idMarca == itemSelected.id_marca){
								viewEquipo.listMarca.selectedItem = _marca;
								changeMarca();
								break;
							}
						}
					}
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de Marcas");
			}
		}
		public function faultCatMarca (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Marcas.");
		}
		
		//catSubMarca
		public function resultSubMarca (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					acListSubmarcas = _event.result as ArrayCollection;
					if(itemSelected != null && itemSelected.id_equipo != null && itemSelected.id_equipo != ""){
						for each(var _submarca:SubMarcaVO in acListSubmarcas){
							if(_submarca.idSubmarca == itemSelected.id_submarca){
								viewEquipo.listSubMarca.selectedItem = _submarca;
								break;
							}
						}
					}
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubMarcas");
			}
		}
		public function faultSubMarca (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las SubMarcas.");
		}
		
	}
}