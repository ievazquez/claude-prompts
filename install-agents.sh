#!/bin/bash

# =============================================================================
# Claude Agents Installer
# Instala agentes genéricos (global) y específicos por tecnología (proyecto)
# =============================================================================

set -e

# Configuración
REPO_URL="git@github.com:TU_USUARIO/claude-prompts.git"  # Cambiar por tu repo
REPO_BRANCH="main"
TEMP_DIR="/tmp/claude-agents-$$"
GLOBAL_DIR="$HOME/.claude/commands"
LOCAL_DIR=".claude/commands"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# =============================================================================
# Funciones auxiliares
# =============================================================================

print_header() {
    echo -e "${BLUE}══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Claude Agents Installer${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════════════${NC}"
}

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${YELLOW}→${NC} $1"; }

show_help() {
    cat << EOF
Uso: install-agents.sh [opciones] <tecnología>

Tecnologías disponibles:
  java        Java + Spring Boot
  python      Python + Django/FastAPI
  node        Node.js + Express
  react       React
  angular     Angular
  vue         Vue.js
  sql         SQL/Databases
  pandas      Python Pandas
  docker      Docker
  kubernetes  Kubernetes

Opciones:
  --global-only     Solo instalar agentes genéricos (global)
  --local-only      Solo instalar agentes de tecnología (sin genéricos)
  --list            Listar agentes disponibles
  --update          Actualizar agentes existentes
  --repo URL        Usar un repositorio diferente
  -h, --help        Mostrar esta ayuda

Ejemplos:
  install-agents.sh java           # Instala genéricos + Java
  install-agents.sh react node     # Instala genéricos + React + Node
  install-agents.sh --global-only  # Solo genéricos
  install-agents.sh --list         # Ver agentes disponibles

EOF
}

# Mapeo de tecnología a directorio
get_tech_path() {
    local tech="$1"
    case "$tech" in
        java)       echo "agents/backend/java" ;;
        python)     echo "agents/backend/python" ;;
        node)       echo "agents/backend/node" ;;
        react)      echo "agents/frontend/react" ;;
        angular)    echo "agents/frontend/angular" ;;
        vue)        echo "agents/frontend/vue" ;;
        sql)        echo "agents/data/sql" ;;
        pandas)     echo "agents/data/python-pandas" ;;
        docker)     echo "agents/devops/docker" ;;
        kubernetes) echo "agents/devops/kubernetes" ;;
        *)          echo "" ;;
    esac
}

# Clonar repositorio
clone_repo() {
    print_info "Clonando repositorio..."

    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi

    if git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$TEMP_DIR" 2>/dev/null; then
        print_success "Repositorio clonado"
    else
        print_error "Error al clonar repositorio"
        print_info "Verifica que tengas acceso SSH configurado para: $REPO_URL"
        exit 1
    fi
}

# Instalar agentes genéricos (global)
install_generic() {
    local source="$TEMP_DIR/agents/generic"

    if [ ! -d "$source" ] || [ -z "$(ls -A "$source" 2>/dev/null)" ]; then
        print_info "No hay agentes genéricos disponibles"
        return
    fi

    print_info "Instalando agentes genéricos en $GLOBAL_DIR..."
    mkdir -p "$GLOBAL_DIR"

    local count=0
    for file in "$source"/*.md; do
        [ -f "$file" ] || continue
        cp "$file" "$GLOBAL_DIR/"
        count=$((count + 1))
    done

    print_success "Instalados $count agentes genéricos"
}

# Instalar agentes de tecnología específica (local al proyecto)
install_tech() {
    local tech="$1"
    local tech_path=$(get_tech_path "$tech")

    if [ -z "$tech_path" ]; then
        print_error "Tecnología desconocida: $tech"
        return 1
    fi

    local source="$TEMP_DIR/$tech_path"

    if [ ! -d "$source" ] || [ -z "$(ls -A "$source" 2>/dev/null)" ]; then
        print_info "No hay agentes disponibles para: $tech"
        return
    fi

    print_info "Instalando agentes de $tech en $LOCAL_DIR..."
    mkdir -p "$LOCAL_DIR"

    local count=0
    for file in "$source"/*.md; do
        [ -f "$file" ] || continue
        cp "$file" "$LOCAL_DIR/"
        count=$((count + 1))
    done

    print_success "Instalados $count agentes de $tech"
}

# Listar agentes disponibles
list_agents() {
    clone_repo

    echo ""
    echo -e "${BLUE}Agentes disponibles:${NC}"
    echo ""

    echo -e "${YELLOW}Genéricos (global):${NC}"
    if [ -d "$TEMP_DIR/agents/generic" ]; then
        for file in "$TEMP_DIR/agents/generic"/*.md 2>/dev/null; do
            [ -f "$file" ] && echo "  - $(basename "$file" .md)"
        done
    fi
    echo ""

    for category in backend frontend data devops; do
        if [ -d "$TEMP_DIR/agents/$category" ]; then
            echo -e "${YELLOW}${category^}:${NC}"
            for tech_dir in "$TEMP_DIR/agents/$category"/*/; do
                [ -d "$tech_dir" ] || continue
                tech=$(basename "$tech_dir")
                echo "  $tech:"
                for file in "$tech_dir"*.md 2>/dev/null; do
                    [ -f "$file" ] && echo "    - $(basename "$file" .md)"
                done
            done
            echo ""
        fi
    done

    cleanup
}

# Limpiar archivos temporales
cleanup() {
    [ -d "$TEMP_DIR" ] && rm -rf "$TEMP_DIR"
}

# =============================================================================
# Main
# =============================================================================

main() {
    local global_only=false
    local local_only=false
    local do_list=false
    local technologies=()

    # Parsear argumentos
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            --global-only)
                global_only=true
                shift
                ;;
            --local-only)
                local_only=true
                shift
                ;;
            --list)
                do_list=true
                shift
                ;;
            --update)
                # Update es el comportamiento por defecto (sobrescribe)
                shift
                ;;
            --repo)
                REPO_URL="$2"
                shift 2
                ;;
            -*)
                print_error "Opción desconocida: $1"
                show_help
                exit 1
                ;;
            *)
                technologies+=("$1")
                shift
                ;;
        esac
    done

    print_header
    echo ""

    # Listar agentes
    if [ "$do_list" = true ]; then
        list_agents
        exit 0
    fi

    # Validar argumentos
    if [ "$global_only" = false ] && [ ${#technologies[@]} -eq 0 ]; then
        print_error "Debes especificar al menos una tecnología o usar --global-only"
        echo ""
        show_help
        exit 1
    fi

    # Clonar repo
    clone_repo
    echo ""

    # Instalar genéricos si no es --local-only
    if [ "$local_only" = false ]; then
        install_generic
    fi

    # Instalar tecnologías específicas si no es --global-only
    if [ "$global_only" = false ]; then
        for tech in "${technologies[@]}"; do
            install_tech "$tech"
        done
    fi

    # Limpiar
    cleanup

    echo ""
    print_success "Instalación completada"
    echo ""
    echo -e "${YELLOW}Agentes instalados en:${NC}"
    [ "$local_only" = false ] && echo "  Global:  $GLOBAL_DIR"
    [ "$global_only" = false ] && echo "  Proyecto: $LOCAL_DIR"
    echo ""
}

# Trap para limpiar en caso de error
trap cleanup EXIT

main "$@"
