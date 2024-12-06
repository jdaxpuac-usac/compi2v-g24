<script lang="ts">
    import parseInput from "$lib/analizador";
    import CodeMirror from "svelte-codemirror-editor"

    let texto = $state("");
    let resultado = $state("");
    
    function analizar() {
        resultado = parseInput(texto);
    }
</script>

<div class="p-5 flex flex-row h-full max-h-full bg-slate-900">
    <div class="h-full w-1/2 mx-2 rounded-md font-extrabold border-white bg-amber-200 border overflow-y-scroll">
        <CodeMirror bind:value={texto} on:change={analizar}/>
    </div>
    <div class="rounded-md border-white bg-amber-200 border-2 h-full w-1/2 mx-2">
        <p class="font-extrabold">
            {resultado}
        </p>
    </div>
</div>
