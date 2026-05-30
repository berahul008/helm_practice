{{- define "myservice.name" -}}
{{- default .Chart.Name .Values.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "myservice.selectorLabels" -}}
{{- $name := include "myservice.name" . -}}
{{- $user := .Values.selectorLabels | default (dict) -}}
app.kubernetes.io/name: {{ $name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $k, $v := $user }}
{{ $k }}: {{ $v | quote }}
{{- end }}
{{- end -}}

{{- define "myservice.commonLabels" -}}
{{- $user := .Values.labels | default (dict) -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- range $k, $v := $user }}
{{ $k }}: {{ $v | quote }}
{{- end }}
{{- end -}}
