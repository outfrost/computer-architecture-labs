# Architektura komputerów 2

## Laboratorium 5. SSE

##### Zadania na laboratorium

1. Napisać prodecurę obliczeniową w zwykły, dotychczasowy sposób (przy użyciu optymalizacji kompilatora `-O3`), a następnie z użyciem SSE i porównać szybkość działania.

	* Procedura ma za zadanie obliczyć całkę oznaczoną z `(1 - x^2) / x` `dx` na zadawanym (stałymi lub parametrami) przedziale.
	* Dobrać szerokości przedziałów całkowania itp. do implementacji, aby nie namnażać błędów niedokładności.
