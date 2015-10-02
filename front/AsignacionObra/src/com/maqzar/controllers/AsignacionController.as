/**
 * Created by Carlos Zaragoza on 09/05/2015.
 */
package com.maqzar.controllers {
	import com.maqzar.dtos.AsignacionDTO;
	import com.maqzar.dtos.AsignacionVO;
	import com.maqzar.dtos.EmpleadoAsignadoVO;
	import com.maqzar.dtos.EmpleadoDisponibleVO;
	import com.maqzar.dtos.EquipoVO;
	import com.maqzar.dtos.EquiposAsignadosObraVO;
	import com.maqzar.dtos.ObraVO;
	import com.maqzar.events.AsignacionEvent;
	import com.maqzar.models.AsignacionModel;
	import com.maqzar.services.AsignacionService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class AsignacionController extends AbstractController {
		public function AsignacionController() {
			super();
		}
		[Inject]
		public var asignacionModel:AsignacionModel;
		
		private var asignacionService:AsignacionService = new AsignacionService();
		private function asignacionFail(e:FaultEvent):void {
			
		}
		public function saveAsignacion(vo:AsignacionVO):void
		{
			executeServiceCall(asignacionService.save(vo),saveResult,asignacionFail);
		}
		[EventHandler(event="ObraEvent.OBRA_LIST_DATA", properties="obra")]
		public function findAllObras(obra:ObraVO):void
		{
			executeServiceCall(asignacionService.findAllObras(obra),findAllObrasResult, asignacionFail);
		}
		
		private function findAllObrasResult(e:ResultEvent):void {
			try{
				trace(e.result);
				if(e.result != null){
					asignacionModel.acObras = e.result as ArrayCollection
				}else{
					Alert.show("No pudo cargar las obras","NOK")
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function saveResult(e:ResultEvent):void {
			Alert.show("AsignacionGuardada");
		}
		
		/*
		 * funcion traer los empleados
		*/
		
		[EventHandler(event="AsignacionEvent.ASIGNACION_GET_EMPLEADOS_DISPONIBLES", properties="empleadosDisponibles")]
		public function findAllEmpleados(empleadosDisponibles:EmpleadoDisponibleVO):void
		{
			executeServiceCall(asignacionService.findAllEmpleados(empleadosDisponibles),findAllEmpleadosResult, asignacionFail);
		}
		
		private function findAllEmpleadosResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					asignacionModel.acPersonalDisponible = e.result as ArrayCollection;
				}else{
					Alert.show("No se cargaron los empleados","NOK")
				}
			} 
			catch(e:Error) 
			{
				trace(e.message);	
			}
		}
		
		
		[EventHandler(event="AsignacionEvent.ASIGNACION_GET_EQUIPOS_DISPONIBLES", properties="equiposDisponibles")]		
		public function findAllEquipos(equiposDisponibles:EquipoVO):void
		{
			executeServiceCall(asignacionService.findAllEquipos(equiposDisponibles),findAllEquiposResult, asignacionFail);
		}
		private function findAllEquiposResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					asignacionModel.acEquiposDisponibles = e.result as ArrayCollection;
				}else{
					Alert.show("No se cargaron los empleados","NOK")
				}
			} 
			catch(e:Error) 
			{
				trace(e.message);	
			}
		}

		[EventHandler(event="AsignacionEvent.ASIGNACION_GET_EQUIPOS_ASIGNADOS", properties="equiposAsignadosObraVO")]
		public function findAllEquiposAsignados(equiposAsignadosObraVO:EquiposAsignadosObraVO):void
		{
			executeServiceCall(asignacionService.findAllEquiposAsignados(equiposAsignadosObraVO),findAllEquiposAsignadosResult, asignacionFail);
		}
		
		private function findAllEquiposAsignadosResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					asignacionModel.acEquiposAsignados = e.result as ArrayCollection;
				}else{
					Alert.show("No se cargaron los empleados","NOK")
				}
			} 
			catch(e:Error) 
			{
				trace(e.message);	
			}
		}
		
		
		[EventHandler(event="AsignacionEvent.ASIGNACION_GET_EMPLEADOS_ASIGNADOS", properties="empleadosAsignados")]
		public function findAllEmpleadosAsignados(empleadosAsignados:EmpleadoAsignadoVO):void
		{
			executeServiceCall(asignacionService.findaAllEmpleadosAsignados(empleadosAsignados),findaAllEmpleadosAsignadosResult, asignacionFail);
		}
		
		private function findaAllEmpleadosAsignadosResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					
					asignacionModel.acEmpleadosAsignados = e.result as ArrayCollection;
				}else{
					Alert.show("No se cargaron los empleados","NOK")
				}
			} 
			catch(e:Error) 
			{
				trace(e.message);	
			}
		}
		
		[EventHandler(event="AsignacionEvent.ASIGNACION_CAMBIA_ESTATUS_EQUIPO", properties="equiposAsignadosObraVO")]
		public function cambiaEstatusEquipo(equiposAsignadosObraVO:EquiposAsignadosObraVO):void
		{
			executeServiceCall(asignacionService.cambiaEstatusEquipo(equiposAsignadosObraVO),cambiaEstatusEquipoResult, asignacionFail);
		}
		
		private function cambiaEstatusEquipoResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					//asignacionModel.acEmpleadosAsignados = e.result as ArrayCollection;
					//Alert.show("Se actualizó","NOK");
					if(e.result == true){
						dispatcher.dispatchEvent(new AsignacionEvent(AsignacionEvent.ASIGNACION_REFRESCA_GRID_DESDE_COMBO));	
					}
					else{
						Alert.show("No actualizó","NOK");
					}
					
					//findAllEmpleadosAsignados(e.result as EmpleadoAsignadoVO);
					
				}else{
					Alert.show("No se cargaron los datos","NOK")
				}
			} 
			catch(e:Error) 
			{
				trace(e.message);	
			}
		}
		
		
		[EventHandler(event="AsignacionEvent.ASIGNACION_CAMBIA_ESTATUS_EMPLEADO", properties="empleadosAsignados")]
		public function cambiaEstatusEmpleado(empleadosAsignados:EmpleadoAsignadoVO):void
		{
			executeServiceCall(asignacionService.cambiaEstatusEmpleado(empleadosAsignados),cambiaEstatusEmpleadoResult, asignacionFail);
		}
		
		private function cambiaEstatusEmpleadoResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					//asignacionModel.acEmpleadosAsignados = e.result as ArrayCollection;
					if(e.result == false){
						Alert.show("No se pudo cambiar el estatus","NOK");
					}else{
						//Alert.show("Se actualizó","NOK");
						dispatcher.dispatchEvent(new AsignacionEvent(AsignacionEvent.ASIGNACION_REFRESCA_GRID_DESDE_COMBO));
						//disparamos la consulta!
						var empleadosDisponiblesEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_GET_EMPLEADOS_DISPONIBLES);
						empleadosDisponiblesEvent.empleadosDisponibles = new EmpleadoDisponibleVO();
						dispatcher.dispatchEvent(empleadosDisponiblesEvent);
						
					}
					
					
					//findAllEmpleadosAsignados(e.result as EmpleadoAsignadoVO);
					
				}else{
					Alert.show("No se cargaron los datos","NOK")
				}
			} 
			catch(error:Error) 
			{
				trace(error.message);	
			}
		}
		
		[EventHandler(event="AsignacionEvent.ADD_PERSONAL", properties="empleadosAsignados")]
		public function addEmpleado(empleadosAsignados:EmpleadoAsignadoVO):void
		{
			executeServiceCall(asignacionService.addEmpleado(empleadosAsignados),addEmpleadoResult, asignacionFail);
		}
		
		private function addEmpleadoResult(e:ResultEvent):void
		{
			try
			{
				if(e.result != null)
				{
					if(e.result == true){
						dispatcher.dispatchEvent(new AsignacionEvent(AsignacionEvent.ASIGNACION_REFRESCA_GRID_DESDE_COMBO));
						// Begin Asigna lista de refresh de personal disponible.
						var empleadosDisponiblesEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_GET_EMPLEADOS_DISPONIBLES);
						empleadosDisponiblesEvent.empleadosDisponibles = new EmpleadoDisponibleVO();
						dispatcher.dispatchEvent(empleadosDisponiblesEvent);
						// End Asigna
					}else
					{
						Alert.show("No puedes agregar el registro", "NOK");
					}
				
				}else{
					Alert.show("No se cargaron los datos","NOK")
				}
			} 
			catch(error:Error) 
			{
				trace(error.message);	
			}
		}
		
		[EventHandler(event="AsignacionEvent.ADD_EQUIPO", properties="equiposAsignadosObraVO")]
		public function addEquipo(equiposAsignadosObraVO:EquiposAsignadosObraVO):void
		{
			executeServiceCall(asignacionService.addEquipo(equiposAsignadosObraVO),addEquipoResult, asignacionFail);
		}
		
		private function addEquipoResult(e:ResultEvent):void {
			try
			{
				if(e.result != null)
				{
					if(e.result == true){
						dispatcher.dispatchEvent(new AsignacionEvent(AsignacionEvent.ASIGNACION_REFRESCA_GRID_DESDE_COMBO));
					}else
					{
						Alert.show("No puedes agregar el registro", "NOK");
					}
				}else{
					Alert.show("No se cargaron los datos","NOK")
				}
			} 
			catch(error:Error) 
			{
				trace(error.message);	
			}
		}
		
		[EventHandler(event="AsignacionEvent.CALL_ASIGNACIONES_DISPONIBLES_EMPLEADOS", properties="asignacionDTO")]
		public function validaEmpleadoDisponible(asignacionDTO:AsignacionDTO):void
		{
			executeServiceCall(asignacionService.infoAsignacionesDisponiblesObra(asignacionDTO),infoAsignacionesDisponiblesObraResult, asignacionFail);
		}
		
		private function infoAsignacionesDisponiblesObraResult(e:ResultEvent):void
		{
			try
			{
				asignacionModel.acAsignacionEmpleados =  e.result as ArrayCollection;
					var equipoAsignadoEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.LISTA_EQUIPOS_ASIGNADOS_A_EMPLEADO);
					equipoAsignadoEvent.listado = e.result as ArrayCollection;
					dispatcher.dispatchEvent(equipoAsignadoEvent);
					
			} 
			catch(error:Error) 
			{
				trace(error.message);	
			}
		}
	}
}
