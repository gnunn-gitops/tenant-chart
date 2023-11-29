{{/* Merge labels from namespace and defaults */}}
{{- define "merge-labels" -}}
{{- $ns := . -}}
{{- if or $.namespace.labels $.values.default.labels }}
{{- $nsLabels := $.namespace.labels | default dict }}
{{- $defaultLabels := dict}}
{{- if and $.values.default $.values.default.labels }}
{{- $defaultLabels = $.values.default.labels }}
{{- end}}
{{- $labels := merge $nsLabels $defaultLabels }}
  labels:
{{ toYaml $labels | indent 4 }}
{{- end }}
{{- end -}}

{{/* Merge annotations from namespace and defaults */}}
{{- define "merge-annotations" -}}
{{- $ns := . -}}
{{- if or $.namespace.annotations $.values.default.annotations }}
{{- $nsAnnotations := $.namespace.annotations | default dict }}
{{- $defaultAnnotations := dict}}
{{- if and $.values.default $.values.default.annotations }}
{{- $defaultAnnotations = $.values.default.annotations }}
{{- end}}
{{- $annotations := merge $nsAnnotations $defaultAnnotations }}
  annotations:
{{ toYaml $annotations | indent 4 }}
{{- end }}
{{- end -}}
