<script lang="ts">
    import parseInput from "$lib/analizador";
    import CodeMirror from "svelte-codemirror-editor";

    let texto = $state(""); 
    let resultado = $state(""); 
    
    function analizar() {
        resultado = parseInput(texto);
    }
    function CargarArchivo(event: Event) {
        const archivo = (event.target as HTMLInputElement).files?.[0];
        
        if (archivo) {
            const reader = new FileReader();
            
            reader.onload = () => {
                texto = reader.result as string;
            };
            
            reader.readAsText(archivo); 
        } else {
            alert('Por favor, selecciona un archivo .txt');
        }
    }
</script>

<div class="p-5 flex flex-col h-screen bg-slate-900">
    <div class="text-cyan-600 text-4xl font-extrabold max-w-screen-sm mb-5 flex justify-center items-center">
        <h1>OCL2 - Grupo 24</h1>
    </div>
    
    <div class="mb-4 flex justify-center">
        <label for="file-upload" class="cursor-pointer px-6 py-2 text-white bg-indigo-900 font-extrabold rounded-md hover:bg-indigo-700 transition-colors">
            Seleccionar archivo
        </label>
        <input id="file-upload" type="file" onchange={CargarArchivo} class="hidden" />
    </div>
    
    <div class="flex flex-row h-full">
        <div class="h-full w-1/2 mx-2 rounded-md font-extrabold border-white bg-amber-200 border overflow-y-scroll">
            <CodeMirror bind:value={texto} on:change={analizar} />
        </div>
        <div class="h-full w-1/2 mx-2 rounded-md border-white bg-amber-200 border-2">
            <p class="font-extrabold">
                {resultado}
            </p>
        </div>
    </div>
</div>
