{{/* Generates common labels */}}
{{- define "hello.labels" -}}
project: {{ .Release.Name }}
{{- end -}}