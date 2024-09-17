% Sistema experto expandido para diagnosticar problemas de computadora

:- dynamic relacion/3.

% Predicado para hacer preguntas y almacenar respuestas
ask(Atributo, Valor) :-
    relacion(si, Atributo, Valor),
    !.
ask(Atributo, Valor) :-
    relacion(no, Atributo, Valor),
    !,
    fail.
ask(Atributo, Valor) :-
    format('~w? (si/no): ', [Atributo]),
    read(Respuesta),
    asserta(relacion(Respuesta, Atributo, Valor)),
    Respuesta == si.

% Predicados
enciende :- ask('La computadora enciende', _).
muestra_imagen :- ask('La pantalla muestra alguna imagen', _).
sistema_operativo_carga :- ask('El sistema operativo carga', _).
ruido_inusual :- ask('Se escucha algún ruido inusual', _).
lento :- ask('El sistema está funcionando más lento de lo normal', _).
conexion_internet :- ask('Hay conexión a internet', _).
archivos_corruptos :- ask('Hay archivos que no se pueden abrir o están corruptos', _).
sobrecalentamiento :- ask('La computadora se siente caliente al tacto', _).
errores_bsod :- ask('Aparecen pantallas azules de error (BSOD)', _).
problemas_perifericos :- ask('Hay problemas con los periféricos (teclado, mouse, etc.)', _).
actualizaciones_pendientes :- ask('Hay actualizaciones del sistema pendientes', _).

% Reglas de diagnóstico
diagnosticar(problema_fuente_poder) :-
    \+ enciende,
    \+ muestra_imagen.
diagnosticar(problema_monitor) :-
    enciende,
    \+ muestra_imagen.
diagnosticar(problema_disco_duro) :-
    enciende,
    muestra_imagen,
    \+ sistema_operativo_carga.
diagnosticar(falla_hardware) :-
    enciende,
    ruido_inusual.
diagnosticar(virus) :-
    sistema_operativo_carga,
    lento,
    archivos_corruptos.
diagnosticar(problema_red) :-
    sistema_operativo_carga,
    \+ conexion_internet.
diagnosticar(necesita_mantenimiento) :-
    sistema_operativo_carga,
    lento,
    \+ archivos_corruptos,
    actualizaciones_pendientes.
diagnosticar(problema_refrigeracion) :-
    sistema_operativo_carga,
    sobrecalentamiento,
    lento.
diagnosticar(conflicto_drivers) :-
    sistema_operativo_carga,
    errores_bsod,
    \+ archivos_corruptos.
diagnosticar(problema_perifericos) :-
    sistema_operativo_carga,
    problemas_perifericos,
    \+ errores_bsod.
diagnosticar(sistema_funciona_correctamente) :-
    sistema_operativo_carga,
    \+ lento,
    conexion_internet,
    \+ archivos_corruptos,
    \+ sobrecalentamiento,
    \+ errores_bsod,
    \+ problemas_perifericos.

% Predicado principal para iniciar el diagnóstico
inicio :-
    retractall(relacion(_, _, _)),
    diagnosticar(Problema),
    format('Diagnóstico: ~w~n', [Problema]).

% Mensaje de bienvenida
:- writeln('Para iniciar el diagnóstico de problemas de computadora, escribe "inicio."').