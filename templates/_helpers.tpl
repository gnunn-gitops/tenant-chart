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
{{- with $labels }}
{{ toYaml . | indent 4 }}
{{- end }}
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
{{- with $annotations }}
{{ toYaml . | indent 4 }}
{{- end }}
{{- end }}
{{- end -}}

{{/* Create operator group */}}
{{- define "create-operator-group" -}}
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: {{ . }}
  namespace: {{ . }}
spec:
  targetNamespaces:
    - {{ . }}
{{- end -}}
