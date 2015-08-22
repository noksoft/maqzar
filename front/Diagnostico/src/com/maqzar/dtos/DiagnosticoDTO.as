/**
 * Created by jess on 08/08/15.
 */
package com.maqzar.dtos {
public class DiagnosticoDTO {
    private var _id_diagnostico:int;
    private var _id_equipo:int;
    private var _fecha_diagnostico:Date;
    private var _estatus_ingreso:int;
    private var _usuario:int;
    public function DiagnosticoDTO() {
    }

    public function get id_diagnostico():int {
        return _id_diagnostico;
    }

    public function set id_diagnostico(value:int):void {
        _id_diagnostico = value;
    }

    public function get id_equipo():int {
        return _id_equipo;
    }

    public function set id_equipo(value:int):void {
        _id_equipo = value;
    }

    public function get fecha_diagnostico():Date {
        return _fecha_diagnostico;
    }

    public function set fecha_diagnostico(value:Date):void {
        _fecha_diagnostico = value;
    }

    public function get estatus_ingreso():int {
        return _estatus_ingreso;
    }

    public function set estatus_ingreso(value:int):void {
        _estatus_ingreso = value;
    }

    public function get usuario():int {
        return _usuario;
    }

    public function set usuario(value:int):void {
        _usuario = value;
    }
}
}
